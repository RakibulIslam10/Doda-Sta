import 'dart:developer';
import 'package:doda_work/views/inbox/controller/s.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../core/api/end_point/api_end_points.dart';
import '../../../core/api/services/api.dart';
import '../../../core/utils/app_storage.dart';
import '../../../widgets/custom_snackbar.dart';

class InboxController extends GetxController {
  final textController = TextEditingController();
  final RxBool isLoading = false.obs;
  final RxBool isPaginationLoading = false.obs;
  final Rx<XFile?> selectedImage = Rx<XFile?>(null);

  String? receiverId;
  String? roomId;
  String? name;
  String? avatar;
  late IO.Socket socket;
  RxList<Map<String, dynamic>> messagesList = <Map<String, dynamic>>[].obs;

  // Pagination
  int limit = 20;
  int skip = 0;
  bool hasMore = true;

  @override
  void onInit() {
    super.onInit();
    receiverId = Get.parameters['receiverId'];

    name = Get.parameters['name'] ?? 'Unknown';
    avatar = Get.parameters['avatar'];
    _initSocket();
    if (roomId?.isNotEmpty ?? false) fetchMessages();
  }



  void _initSocket() {
    socket = IO.io(
      "http://10.10.20.52:6002"
          "?id=${AppStorage.uId}&role=${AppStorage.users}",
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .setReconnectionAttempts(10)
          .build(),
    );

    socket.onConnect((_) {
      log("✅ Socket connected: ${AppStorage.uId}");
    });

    socket.onDisconnect((_) {
      log("❌ Socket disconnected");
    });


    final String myId = AppStorage.uId;

// New message listener
    socket.on("message_new/$receiverId", (data) {
      log("📩 New Message: $data");
      if (data["sender"]["_id"] == AppStorage.uId) return;


      messagesList.add({
        "message": data["text"] ?? '',
        "isMe": false,
        "isSent": true,
        "type": data["type"] ?? "text",
        "images": data["images"],
      });
    });

// Conversation update listener
    socket.on("conversation_update/$myId", (data) {
      log("🔄 Conversation updated: $data");
    });

  }



















  Future<void> fetchMessages({bool isPagination = false}) async {
    if (isPagination && !hasMore) return;

    if (isPagination) {
      isPaginationLoading.value = true;
    } else {
      isLoading.value = true;
    }

    await ApiRequest.get(
      fromJson: AllConversationModel.fromJson,
      endPoint: '${ApiEndPoints.allMessage}/$receiverId?page=1&limit=$limit',
      isLoading: isLoading,
      onSuccess: (result) {
        final msgs = <Map<String, dynamic>>[];

        for (var conversion in result.conversation.messages ?? []) {
          msgs.add({
            "message": conversion.message ?? '',
            "isMe": conversion.isMe ?? false,
            "isSent": true,
            // "formattedTime": Helpers.formatTimestamp(conversion.createdAt),
            "id": conversion.id,
            "type": conversion.type ?? "text",
            "files": conversion.files,
          });
        }

        if (isPagination) {
          messagesList.insertAll(0, msgs);
        } else {
          messagesList.clear();
          messagesList.addAll(msgs);
        }

        skip += msgs.length;
        if (msgs.length < limit) hasMore = false;
      },
    );

    isPaginationLoading.value = false;
    isLoading.value = false;
  }

  Future<void> pickImageFromGallery() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (image != null) selectedImage.value = image;
    } catch (e) {
      CustomSnackBar.error('Failed to pick image');
    }
  }

  void removeImage() => selectedImage.value = null;

  void sendMessage() {
    final msg = textController.text.trim();
    final hasImage = selectedImage.value != null;

    if (msg.isEmpty && !hasImage) return;

    if (hasImage) {
      // _sendImageWithText(msg);
    } else {
      // Add text locally for sender
      final tempId = DateTime.now().millisecondsSinceEpoch.toString();
      messagesList.add({
        "id": tempId,
        "message": msg,
        "isMe": true,
        "isSent": true,
        // "formattedTime": Helpers.formatTimestamp(DateTime.now().toString()),
        "type": "text",
      });

      // Send via socket
      socket.emit("message", {"receiver": receiverId, "message": msg});

      textController.clear();
    }
  }

  // Future<void> _sendImageWithText(String message) async {
  //   if (selectedImage.value == null) return;
  //
  //   final tempId = DateTime.now().millisecondsSinceEpoch.toString();
  //   final localPath = selectedImage.value!.path;
  //
  //   // Add message + image bubble immediately
  //   messagesList.add({
  //     "id": tempId,
  //     "isMe": true,
  //     "type": "file",
  //     "files": [localPath],
  //     "message": message,
  //     "isLoading": true,
  //     "isSent": false,
  //     // "formattedTime": Helpers.formatTimestamp(DateTime.now().toString()),
  //   });
  //
  //   selectedImage.value = null;
  //   textController.clear();
  //
  //   try {
  //     final result = await ApiRequest.multiMultipartRequest(
  //       reqType: "POST",
  //       fromJson: BasicSuccessModel.fromJson,
  //       endPoint: ApiEndPoints.chats,
  //       isLoading: RxBool(false),
  //       files: {"files": File(localPath)},
  //       body: {
  //         "receiver": receiverId,
  //         if (message.isNotEmpty) "message": message,
  //       },
  //       onSuccess: (res) {
  //         final index = messagesList.indexWhere((m) => m["id"] == tempId);
  //         if (index != -1) {
  //           messagesList[index] = {
  //             ...messagesList[index],
  //             "isSent": true,
  //             "isLoading": false,
  //             "message": message,
  //             "files": messagesList[index]["files"],
  //           };
  //           messagesList.refresh();
  //         }
  //
  //         socket.emit("message", {
  //           "receiver": receiverId,
  //           "message": message,
  //           "files": [localPath],
  //           "type": "file",
  //         });
  //       },
  //     );
  //   } catch (e) {
  //     messagesList.removeWhere((m) => m["id"] == tempId);
  //     CustomSnackBar.error("Failed to send message");
  //     log("Error sending image+text: $e");
  //   }
  // }

  @override
  void onClose() {
    socket.disconnect();
    socket.dispose();
    textController.dispose();
    super.onClose();
  }
}
