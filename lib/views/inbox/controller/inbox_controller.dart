import 'dart:developer';
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
  final RxBool isLoading = false.obs;
  final RxBool isPaginationLoading = false.obs;
  final Rx<XFile?> selectedImage = Rx<XFile?>(null);
  final String myId = AppStorage.uId;

  // Argument
  String? receiverId;
  String? name;
  String? avatar;

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
    if (receiverId?.isNotEmpty ?? false) getOldMessages();
  }

  late IO.Socket socket;
  RxList<Map<String, dynamic>> messagesList = <Map<String, dynamic>>[].obs;

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

    // New message listener
    socket.on("message_new/$receiverId", (data) {
      log("📩 New Message: $data");
      if (data["sender"]["id"] == AppStorage.uId) return;

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

        for (var conversion in result.conversation.messages) {
          newMsg.add({
            "message": conversion.text,
            "isMe": conversion.sender.id == myId,
            "isSent": true,
            "id": conversion.id,
            "type": conversion.images.isNotEmpty ? "image" : "text",
            "files": conversion.images,
            "formattedTime": Helpers.formatTimestamp(
              conversion.createdAt.toString(),
            ),
            "video": conversion.video,
            "seen": conversion.seen,
          });
        }

        if (isPagination) {
          messagesList.insertAll(0, newMsg);
        } else {
          messagesList.clear();
          messagesList.addAll(newMsg);
        }

        skip += newMsg.length;
        if (newMsg.length < limit) hasMore = false;
      },
    );

    isPaginationLoading.value = false;
    isLoading.value = false;
  }

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
        "formattedTime": Helpers.formatTimestamp(DateTime.now().toString()),
        "type": "text",
      });

      // Send via socket
      socket.emit("message_new", {
        "sender": {"id": myId, "role": AppStorage.users},
        "receiver": {
          "id": receiverId,
          "role": AppStorage.users == "USER" ? "PROVIDER" : "USER",
        },
        "text": msg,
        "images": [],
        "video": "",
        "videoCover": "",
      });

      textController.clear();
    }
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

  @override
  void onClose() {
    socket.disconnect();
    socket.dispose();
    textController.dispose();
    super.onClose();
  }
}
