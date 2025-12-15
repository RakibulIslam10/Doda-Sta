import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:doda_work/core/api/model/basic_success_model.dart';
import 'package:doda_work/views/inbox/controller/s.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:http/http.dart' hide MultipartFile;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../core/api/end_point/api_end_points.dart';
import '../../../core/api/services/api.dart';
import '../../../core/helpers/helpers.dart';
import '../../../core/utils/app_storage.dart';
import '../../../widgets/custom_snackbar.dart';

class InboxController extends GetxController {
  final textController = TextEditingController();

  // Argument
  String? receiverId;
  String? name;
  String? avatar;

  @override
  void onInit() {
    super.onInit();
    receiverId = Get.parameters['receiverId'];
    name = Get.parameters['name'] ?? 'Unknown';
    avatar = Get.parameters['avatar'] ?? '';
    _initSocket();
    if (receiverId?.isNotEmpty ?? false) getOldMessages();
  }

  late IO.Socket socket;
  final String myId = AppStorage.uId;
  RxList<Map<String, dynamic>> messagesList = <Map<String, dynamic>>[].obs;

  void _initSocket() {
    socket = IO.io(
      "http://10.10.20.52:6002"
      "?id=$myId&role=${AppStorage.users}",
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .setReconnectionAttempts(10)
          .build(),
    );

    socket.onConnect((_) {
      log("✅ Socket connected: $myId");
    });

    socket.onDisconnect((_) {
      log("❌ Socket disconnected");
    });

    // New message listener - FIXED for instant image display
    socket.on("message_new/$receiverId", (data) {
      log("📩 New Message: $data");
      if (data["sender"]["id"] == myId) return;

      // ✅ Parse images array properly
      List<String> imagesList = [];

      if (data["images"] != null && data["images"] is List) {
        imagesList = (data["images"] as List)
            .map((path) => path.toString())
            .toList();
      }

      messagesList.add({
        "message": data["text"] ?? '',
        "isMe": false,
        "isSent": true,
        "type": imagesList.isNotEmpty ? "image" : "text",
        // ✅ Set type based on images
        "images": imagesList,
        "video": data["video"] ?? "",
        "formattedTime": Helpers.formatTimestamp(DateTime.now().toString()),
        "isUploading": false,
        // ✅ Not uploading, it's received message
      });

      // Auto scroll to bottom
      shouldAutoScroll.value = true;
    });

    // Conversation update listener
    socket.on("conversation_update/$myId", (data) {
      log("🔄 Conversation updated: $data");
    });
  }

  // ============= Get Old Messages =============
  final RxBool isLoading = false.obs;
  final RxBool isPaginationLoading = false.obs;

  int limit = 20;
  int skip = 0;
  bool hasMore = true;
  RxBool isBlock = false.obs;
  RxBool isBlockedByMe = false.obs;

  Future<void> getOldMessages({bool isPagination = false}) async {
    if (isPagination && !hasMore) return;

    if (isPagination) {
      isPaginationLoading.value = true;
    } else {
      isLoading.value = true;
    }

    await ApiRequest.get(
      fromJson: AllConversationModel.fromJson,
      endPoint: '${ApiEndPoints.allMessage}$receiverId&page=1&limit=$limit',
      isLoading: isLoading,
      onSuccess: (result) {
        isBlock.value = result.blockStatus.isBlocked;
        isBlockedByMe.value = result.blockStatus.isBlockedByYou;

        final newMsg = <Map<String, dynamic>>[];

        for (final conversion in result.conversation?.messages ?? []) {
          newMsg.add({
            "message": conversion.text,
            "isMe": conversion.sender.id == myId,
            "isSent": true,
            "id": conversion.id,
            "type": (conversion.images.isNotEmpty)
                ? "image"
                : (conversion.video.isNotEmpty ? "video" : "text"),
            "images": conversion.images,
            "formattedTime": Helpers.formatTimestamp(
              conversion.createdAt.toIso8601String(),
            ),
            "video": conversion.video,
            "seen": conversion.seen,
            "isUploading": false, // ✅ Old messages are not uploading
          });
        }

        final reversedMsg = newMsg.reversed.toList();

        if (isPagination) {
          messagesList.insertAll(0, reversedMsg);
        } else {
          messagesList.clear();
          messagesList.addAll(reversedMsg);
        }

        skip += newMsg.length;
        if (newMsg.length < limit) hasMore = false;
      },
    );

    isPaginationLoading.value = false;
    isLoading.value = false;
  }

  // ============= Multiple Image Selection =============
  final RxList<XFile> selectedImages = <XFile>[].obs;
  final int maxImageCount = 5;
  final RxBool isProcessingImages = false.obs;
  final RxBool shouldAutoScroll = true.obs;

  // ============= Image URL Helper =============
  String getImageUrl(String path) {
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return path; // Already full URL
    }
    // Backend base URL + path (backslash replace করা)
    return 'http://10.10.20.52:6002/$path'.replaceAll('\\', '/');
  }

  // ============= Send Message =============
  void sendMessage() {
    final msg = textController.text.trim();
    final hasImages = selectedImages.isNotEmpty;

    if (msg.isEmpty && !hasImages) return;

    if (hasImages) {
      _sendMessageWithImages(msg);
    } else {
      _sendTextMessage(msg);
    }
  }

  // Send text-only message
  void _sendTextMessage(String text) {
    final tempId = DateTime.now().millisecondsSinceEpoch.toString();
    shouldAutoScroll.value = true;

    messagesList.add({
      "id": tempId,
      "message": text,
      "isMe": true,
      "isSent": true,
      "formattedTime": Helpers.formatTimestamp(DateTime.now().toString()),
      "type": "text",
    });

    socket.emit("message_new", {
      "sender": {"id": myId, "role": AppStorage.users},
      "receiver": {
        "id": receiverId,
        "role": AppStorage.users == "USER" ? "PROVIDER" : "USER",
      },
      "text": text,
      "images": [],
      "video": "",
      "videoCover": "",
    });

    textController.clear();
  }

  // Send message with images
  Future<void> _sendMessageWithImages(String text) async {
    try {
      final tempId = DateTime.now().millisecondsSinceEpoch.toString();
      shouldAutoScroll.value = true;

      // ✅ Show message with uploading state (local preview with LOCAL paths)
      messagesList.add({
        "id": tempId,
        "message": text,
        "isMe": true,
        "isSent": false,
        "formattedTime": Helpers.formatTimestamp(DateTime.now().toString()),
        "type": "image",
        "images": selectedImages.map((img) => img.path).toList(),
        // ✅ LOCAL paths for instant display
        "isUploading": true,
        // ✅ Flag for showing local images
      });

      // Upload images to server
      final List<String> uploadedImagePaths = await _uploadImages(
        selectedImages,
      );

      if (uploadedImagePaths.isEmpty) {
        CustomSnackBar.error('Failed to upload images');
        messagesList.removeWhere((msg) => msg["id"] == tempId);
        return;
      }

      // ✅ Update message with uploaded BACKEND paths
      final messageIndex = messagesList.indexWhere(
        (msg) => msg["id"] == tempId,
      );
      if (messageIndex != -1) {
        messagesList[messageIndex] = {
          ...messagesList[messageIndex],
          "isSent": true,
          "isUploading": false, // ✅ Now show backend images
          "images": uploadedImagePaths, // ✅ BACKEND paths
        };
      }

      // ✅ Emit to socket with backend paths
      socket.emit("message_new", {
        "sender": {"id": myId, "role": AppStorage.users},
        "receiver": {
          "id": receiverId,
          "role": AppStorage.users == "USER" ? "PROVIDER" : "USER",
        },
        "text": text,
        "images": uploadedImagePaths, // ✅ Backend paths
        "video": "",
        "videoCover": "",
      });

      log('✅ Message sent with ${uploadedImagePaths.length} images');

      // Clear input
      textController.clear();
      selectedImages.clear();
    } catch (e) {
      log('❌ Error sending images: $e');
      CustomSnackBar.error('Failed to send images');
    }
  }

  Future<List<String>> _uploadImages(List<XFile> images) async {
    try {
      final List<String> uploadedPaths = [];
      final dio = Dio();

      for (int i = 0; i < images.length; i++) {
        final image = images[i];

        // Detect MIME type
        String mimeType = 'image/jpeg';
        if (image.path.toLowerCase().endsWith('.png')) {
          mimeType = 'image/png';
        } else if (image.path.toLowerCase().endsWith('.jpg') ||
            image.path.toLowerCase().endsWith('.jpeg')) {
          mimeType = 'image/jpeg';
        } else if (image.path.toLowerCase().endsWith('.gif')) {
          mimeType = 'image/gif';
        } else if (image.path.toLowerCase().endsWith('.webp')) {
          mimeType = 'image/webp';
        }

        final formData = FormData.fromMap({
          'chatImage': await MultipartFile.fromFile(
            image.path,
            filename: image.name,
            contentType: MediaType.parse(mimeType),
          ),
        });

        log('📤 Uploading image ${i + 1}/${images.length}: ${image.name}');

        final response = await dio.post(
          'http://10.10.20.52:6002/chat/chat-images-video',
          data: formData,
          options: Options(
            headers: {
              'Authorization': 'Bearer ${AppStorage.token}',
              'Content-Type': 'multipart/form-data',
            },
            validateStatus: (status) => status! < 500,
          ),
          onSendProgress: (sent, total) {
            final progress = (sent / total * 100).toStringAsFixed(0);
            log('📊 Upload progress: $progress%');
          },
        );

        log('📥 Response status: ${response.statusCode}');
        log('📥 Response data: ${response.data}');

        if (response.statusCode == 200 || response.statusCode == 201) {
          // ✅ Backend response থেকে images array extract
          final responseData = response.data;

          if (responseData['success'] == true &&
              responseData['images'] != null &&
              responseData['images'] is List) {
            final imagesList = responseData['images'] as List;

            // প্রতিটি image path add করা
            for (var imagePath in imagesList) {
              if (imagePath != null && imagePath.toString().isNotEmpty) {
                uploadedPaths.add(imagePath.toString());
                log('✅ Image path added: $imagePath');
              }
            }
          } else {
            log('❌ Invalid response structure: ${response.data}');
            CustomSnackBar.error(
              'Image ${i + 1} upload failed: Invalid response',
            );
          }
        } else {
          log('❌ Upload failed with status ${response.statusCode}');
          CustomSnackBar.error('Image ${i + 1} upload failed');
        }
      }

      log('✅ Total uploaded paths: ${uploadedPaths.length}');
      return uploadedPaths;
    } catch (e) {
      log('❌ Error uploading images: $e');
      if (e is DioException) {
        log('❌ DioException type: ${e.type}');
        log('❌ DioException Response: ${e.response?.data}');
        log('❌ DioException Message: ${e.message}');
        log('❌ DioException StatusCode: ${e.response?.statusCode}');
      }
      CustomSnackBar.error('Network error during upload');
      return [];
    }
  }

  RxBool isBlockLoading = false.obs;

  Future<BasicSuccessModel> blockUser() async {
    return await ApiRequest.post(
      fromJson: BasicSuccessModel.fromJson,
      endPoint: ApiEndPoints.blockUser,
      isLoading: isBlockLoading,
      body: {},
      queryParams: {'partnerId': receiverId},
      onSuccess: (result) => Get.close(1),
    );
  }

  Future<BasicSuccessModel> unBlockUser() async {
    return await ApiRequest.post(
      fromJson: BasicSuccessModel.fromJson,
      endPoint: ApiEndPoints.unBlockUser,
      isLoading: isBlockLoading,
      body: {},
      queryParams: {'partnerId': receiverId},
      onSuccess: (result) => Get.close(1),
    );
  }

  // Pick multiple images from gallery
  Future<void> pickImagesFromGallery() async {
    try {
      final List<XFile> images = await ImagePicker().pickMultiImage(
        imageQuality: 80,
        maxWidth: 1920,
        maxHeight: 1920,
      );

      if (images.isEmpty) return;

      final totalImages = selectedImages.length + images.length;
      if (totalImages > maxImageCount) {
        CustomSnackBar.error(
          'Maximum $maxImageCount images allowed. You can select ${maxImageCount - selectedImages.length} more.',
        );
        return;
      }

      selectedImages.addAll(images);
      log('✅ ${images.length} images selected from gallery');
    } catch (e) {
      log('❌ Error picking images: $e');
      CustomSnackBar.error('Failed to pick images');
    }
  }

  Future<void> pickImageFromCamera() async {
    try {
      if (selectedImages.length >= maxImageCount) {
        CustomSnackBar.error('Maximum $maxImageCount images already selected');
        return;
      }

      final XFile? image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 1920,
        maxHeight: 1920,
      );

      if (image != null) {
        selectedImages.add(image);
        log('✅ Image captured from camera');
      }
    } catch (e) {
      log('❌ Error capturing image: $e');
      CustomSnackBar.error('Failed to capture image');
    }
  }

  void showImagePickerOptions() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.blue),
              title: const Text('Choose from Gallery'),
              subtitle: Text('Select up to $maxImageCount images'),
              onTap: () {
                Get.back();
                pickImagesFromGallery();
              },
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.green),
              title: const Text('Take Photo'),
              onTap: () {
                Get.back();
                pickImageFromCamera();
              },
            ),
            if (selectedImages.isNotEmpty) ...[
              const SizedBox(height: 8),
              ListTile(
                leading: const Icon(Icons.delete_outline, color: Colors.red),
                title: const Text('Clear All Images'),
                subtitle: Text('${selectedImages.length} image(s) selected'),
                onTap: () {
                  Get.back();
                  clearAllImages();
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  void removeImage(int index) {
    if (index >= 0 && index < selectedImages.length) {
      selectedImages.removeAt(index);
      log('✅ Image removed at index $index');
    }
  }

  void clearAllImages() {
    selectedImages.clear();
    log('✅ All images cleared');
  }

  @override
  void onClose() {
    socket.disconnect();
    socket.dispose();
    textController.dispose();
    super.onClose();
  }
}
