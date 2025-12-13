import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../core/api/end_point/api_end_points.dart';
import '../../../core/api/services/api.dart';
import '../../../core/utils/app_storage.dart';

class InboxController extends GetxController {
  // TextField
  final textController = TextEditingController();

  // Scroll Controller
  final scrollController = ScrollController();

  // Participant Info
  final participantName = ''.obs;
  final participantEmail = ''.obs;
  final participantProfile = ''.obs;

  // Dynamic Receiver Info
  String? receiverId;
  String? receiverRole;

  // Message List
  final RxList<Map<String, dynamic>> messagesLists =
      <Map<String, dynamic>>[].obs;

  // Chat images
  final ImagePicker _picker = ImagePicker();

  // Socket
  late IO.Socket socket;

  String? conversationId;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments ?? {};

    conversationId = args["conversationId"];
    receiverId = args["userId"]; // 👍 RECEIVER ID
    receiverRole = args["role"]; // 👍 RECEIVER ROLE

    log("📌 Receiver ID: $receiverId");
    log("📌 Receiver Role: $receiverRole");

    if (conversationId != null) {
      fetchConversation(conversationId!);
    }

    connectToSocket();
  }

  // ---------------------------------------------------
  // SOCKET CONNECTION
  // ---------------------------------------------------
  void connectToSocket() {
    // Use the HTTP URL, not WebSocket URL for Socket.IO
    // Socket.IO will handle the WebSocket connection internally
    final url = ApiEndPoints.baseUrl; // e.g., "http://10.10.20.52:6002"

    log("🔌 Connecting to socket: $url");

    socket = IO.io(
      url,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .setQuery({"id": AppStorage.uId, "role": AppStorage.role})
          .enableAutoConnect()
          .setReconnectionAttempts(10)
          .setReconnectionDelay(1000)
          .setTimeout(20000)
          .build(),
    );

    // ===========================================
    // ✅ 1. DEBUG LISTENERS (OUTSIDE onConnect!)
    // ===========================================

    // Listen to ALL events for debugging
    socket.onAny((event, data) {
      log(
        "🎯 [SOCKET EVENT] '$event': ${data != null ? data.toString() : 'null'}",
      );
    });

    socket.onConnect((_) => log("🔄 Connecting to server..."));

    socket.onConnect((_) {
      log("✅✅✅ SOCKET CONNECTED! ID: ${socket.id}");
      log("✅ Query params: id=${AppStorage.uId}, role=${AppStorage.role}");

      // Test connection
      socket.emit("ping", {
        "from": "flutter",
        "time": DateTime.now().toString(),
      });
    });

    socket.onConnectError((err) => log("❌ Connect error: $err"));
    socket.onError((_) => log("⏰ Connect timeout"));
    socket.onError((err) => log("❌ Socket error: $err"));
    socket.onDisconnect((reason) {
      log("❌ Disconnected: $reason");
    });

    // ===========================================
    // ✅ 2. MESSAGE EVENT LISTENERS
    // ===========================================

    // Listen for ping response
    socket.on("pong", (data) {
      log("🏓 Pong received: $data");
    });
    // Listen for message acknowledgments
    socket.on("message_ack", (data) {
      log("📬 Message acknowledged: $data");
    });

    socket.on("message_error", (error) {
      log("❌ Message error: $error");
    });

    // ✅ CORRECT: Listen for conversation updates

    socket.on("conversation_update", (data) {
      log("🔄 Conversation update received: $data");

      // Check if this message is for the current conversation
      if (data != null && data["sender"] != null && data["receiver"] != null) {
        final senderId = data["sender"]["id"];
        final receiverId = data["receiver"]["id"];

        if (receiverId == AppStorage.uId || senderId == receiverId) {
          messagesLists.add({
            "textMsg": data["text"] ?? "",
            "senderId": senderId ?? "",
            "isMe": senderId == AppStorage.uId,
            "time": DateTime.now().toString(),
          });
          _scrollToBottom();
        }
      }
    });

    // ✅ ALSO listen to the specific event with your ID
    socket.on("conversation_update/${AppStorage.uId}", (data) {
      log("📥 Direct message for me: $data");

      if (data != null) {
        messagesLists.add({
          "textMsg": data["text"] ?? "",
          "senderId": data["sender"]?["id"] ?? "",
          "isMe": false,
          "time": DateTime.now().toString(),
        });
        _scrollToBottom();
      }
    });

    // Listen for any new message event
    socket.on("message_new", (data) {
      log("📥 Generic message_new event: $data");
    });

    socket.on("new_message", (data) {
      log("📥 New message event: $data");
    });

    // ===========================================
    // ✅ 3. CONNECT THE SOCKET (ONLY ONCE!)
    // ===========================================

    log("🚀 Attempting socket connection...");
    socket.connect();
  }

  // ---------------------------------------------------
  // SEND TEXT MESSAGE
  // ---------------------------------------------------
  void sendMessage() {
    final text = textController.text.trim();
    if (text.isEmpty) return;

    if (receiverId == null || receiverRole == null) {
      Get.snackbar("Error", "Receiver information missing");
      return;
    }

    // Check connection
    if (!socket.connected) {
      log("❌ Socket not connected!");
      Get.snackbar("Error", "Not connected to server");
      return;
    }

    log("✅ Socket connected: ${socket.connected}, ID: ${socket.id}");

    // Prepare message data (match your Postman format)
    final messageData = {
      "sender": {
        "id": AppStorage.uId,
        "role": AppStorage.role.toUpperCase(), // "USER"
      },
      "receiver": {
        "id": receiverId, // "6901b96e81b56cadc12679e3"
        "role": receiverRole, // "PROVIDER"
      },
      "text": text,
      "images": [],
      "video": "",
      "videoCover": "",
      "timestamp": DateTime.now().toIso8601String(),
    };

    log("=" * 50);
    log("🚀 SENDING MESSAGE");
    log("=" * 50);
    log("📤 Event: 'message_new'");
    log("📦 Payload: ${messageData.toString()}");
    log("=" * 50);

    // ===========================================
    // ✅ TRY DIFFERENT EVENT NAMES
    // ===========================================

    // Try these event names one by one
    List<String> eventsToTry = [
      "message_new", // Most likely
      "send_message",
      "chat_message",
      "new_message",
      "message",
    ];

    for (var event in eventsToTry) {
      log("🔄 Trying event: '$event'");
      socket.emit(event, messageData);
    }

    // Also try with acknowledgement
    socket.emitWithAck(
      "message_new",
      messageData,
      ack: (response) {
        if (response != null) {
          log("✅✅✅ SERVER ACKNOWLEDGED: $response");
        } else {
          log("⚠️ No acknowledgement from server");
        }
      },
    );

    // ===========================================
    // ✅ UPDATE UI (Optimistic update)
    // ===========================================

    messagesLists.add({
      "textMsg": text,
      "senderId": AppStorage.uId,
      "isMe": true,
      "time": DateTime.now().toString(),
    });

    textController.clear();
    _scrollToBottom();

    log("✅ Message added to UI");
  }

  // ---------------------------------------------------
  // PICK IMAGE
  // ---------------------------------------------------
  Future<void> pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      sendImageMessage(image.path);
    }
  }

  // ---------------------------------------------------
  // SEND IMAGE MESSAGE
  // ---------------------------------------------------
  void sendImageMessage(String imagePath) {
    messagesLists.add({
      "textMsg": "",
      "image": imagePath,
      "senderId": AppStorage.uId,
      "time": DateTime.now().toString(),
    });

    _scrollToBottom();
  }

  // ---------------------------------------------------
  // AUTO SCROLL
  // ---------------------------------------------------
  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // ---------------------------------------------------
  // FETCH OLD MESSAGES
  // ---------------------------------------------------
  Future<void> fetchConversation(String conversationId) async {

    try {
      await ApiRequest.get(
        endPoint: ApiEndPoints.getConversationById(conversationId),
        isLoading: false.obs,
        fromJson: (json) {
          final conv = json['conversation'];
          final part = json['participant'];

          participantName.value = part['name'] ?? '';
          participantEmail.value = part['email'] ?? '';
          participantProfile.value = part['profileImage'] ?? '';

          final List<dynamic> messages = conv["messages"] ?? [];

          final List<Map<String, dynamic>> formatted = messages.map((m) {

            return {

              "textMsg": m["text"] ?? "",
              "senderId": m["sender"]["id"] ?? "",
              "image": (m["images"] != null && m["images"].isNotEmpty) ? m["images"][0] : null,
              "time": m["createdAt"] ?? "",

            };

          }).toList();

          // ✅ Clear old messages first
          messagesLists.clear();
          messagesLists.addAll(formatted);

          // Scroll to last message after UI renders
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollToBottom();
          });

          return true;
        },
      );
    } catch (e) {
      log("❌ Error fetching conversation: $e");
    }
  }

  @override
  void onClose() {
    try {
      socket.dispose();
      socket.disconnect();
    } catch (_) {}

    textController.dispose();
    super.onClose();
  }
}
