import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:doda_work/views/inbox/controller/s.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

    // New message listener
    socket.on("message_new/$receiverId", (data) {
      log("📩 New Message: $data");
      if (data["sender"]["id"] == myId) return;

      messagesList.add({
        "message": data["text"] ?? '',
        "isMe": false,
        "isSent": true,
        "type": data["type"] ?? "text",
        "images": data["images"] ?? [],
        "formattedTime": Helpers.formatTimestamp(DateTime.now().toString()),
      });
    });

    // Conversation update listener
    socket.on("conversation_update/$myId", (data) {
      log("🔄 Conversation updated: $data");
    });
  }

  // get old message
  final RxBool isLoading = false.obs;
  final RxBool isPaginationLoading = false.obs;

  int limit = 20;
  int skip = 0;
  bool hasMore = true;

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
            "files": conversion.images,
            "formattedTime": Helpers.formatTimestamp(
              conversion.createdAt.toIso8601String(),
            ),
            "video": conversion.video,
            "seen": conversion.seen,
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
// InboxController এ add করুন
  final RxBool shouldAutoScroll = true.obs;


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

  // Send message with images (Base64)
  Future<void> _sendMessageWithImages(String text) async {
    try {
      isProcessingImages.value = true;
      final tempId = DateTime.now().millisecondsSinceEpoch.toString();
      shouldAutoScroll.value = true;

      // Add temporary message to UI
      messagesList.add({
        "id": tempId,
        "message": text,
        "isMe": true,
        "isSent": false,
        "formattedTime": Helpers.formatTimestamp(DateTime.now().toString()),
        "type": "image",
        "images": selectedImages.map((img) => img.path).toList(),
        "isUploading": true,
      });

      // Convert images to base64
      final List<String> base64Images = await _convertImagesToBase64(selectedImages);

      if (base64Images.isEmpty) {
        CustomSnackBar.error('Failed to process images');
        messagesList.removeWhere((msg) => msg["id"] == tempId);
        isProcessingImages.value = false;
        return;
      }

      // Update message status
      final messageIndex = messagesList.indexWhere((msg) => msg["id"] == tempId);
      if (messageIndex != -1) {
        messagesList[messageIndex] = {
          ...messagesList[messageIndex],
          "isSent": true,
          "isUploading": false,
          "images": base64Images,
        };
      }

      // Send via socket with base64 images
      socket.emit("message_new", {
        "sender": {"id": myId, "role": AppStorage.users},
        "receiver": {
          "id": receiverId,
          "role": AppStorage.users == "USER" ? "PROVIDER" : "USER",
        },
        "text": text,
        "images": base64Images, // Base64 strings array
        "video": "",
        "videoCover": "",
      });

      log('✅ Message with ${base64Images.length} images sent via socket');

      // Clear input
      textController.clear();
      selectedImages.clear();
      isProcessingImages.value = false;
    } catch (e) {
      log('❌ Error sending images: $e');
      CustomSnackBar.error('Failed to send images');
      isProcessingImages.value = false;
    }
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
    } catch (e) {
      log('❌ Error picking images: $e');
      CustomSnackBar.error('Failed to pick images');
    }
  }

  // Pick single image from camera
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
      }
    } catch (e) {
      log('❌ Error capturing image: $e');
      CustomSnackBar.error('Failed to capture image');
    }
  }



  // Convert images to base64
  Future<List<String>> _convertImagesToBase64(List<XFile> images) async {
    try {
      final List<String> base64List = [];

      for (int i = 0; i < images.length; i++) {
        final image = images[i];
        log('📷 Converting image ${i + 1}/${images.length} to base64...');

        // Read file as bytes
        final File file = File(image.path);
        final List<int> imageBytes = await file.readAsBytes();

        // Convert to base64
        final String base64Image = base64Encode(imageBytes);

        // Optional: Add data URI prefix if needed by your backend
        // final String base64WithPrefix = 'data:image/jpeg;base64,$base64Image';

        base64List.add(base64Image);
        log('✅ Image ${i + 1} converted successfully');
      }

      return base64List;
    } catch (e) {
      log('❌ Error converting images to base64: $e');
      return [];
    }
  }

  // Show image picker options
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











  // Remove specific image
  void removeImage(int index) {
    if (index >= 0 && index < selectedImages.length) {
      selectedImages.removeAt(index);
    }
  }

  // Clear all images
  void clearAllImages() => selectedImages.clear();

  @override
  void onClose() {
    socket.disconnect();
    socket.dispose();
    textController.dispose();
    super.onClose();
  }
}