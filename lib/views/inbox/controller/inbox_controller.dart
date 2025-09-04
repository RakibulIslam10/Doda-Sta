import 'package:image_picker/image_picker.dart';
import 'package:web_socket_channel/io.dart';
import '../../../core/utils/basic_import.dart';
import '../model/send_message_model.dart';

class InboxController extends GetxController {
  /// Chat list
  final messageList = <MessageModel>[].obs;

  /// Input & scroll controllers
  final textController = TextEditingController();
  final scrollController = ScrollController();

  /// WebSocket channel
  late IOWebSocketChannel channel;

  /// Image picker
  final ImagePicker _picker = ImagePicker();

  /// Reactive state
  var hasText = false.obs;

  /// ✅ Connect to WebSocket on init
  @override
  void onInit() {
    super.onInit();
    connectToSocket();

    /// 🔥 Track text input changes
    textController.addListener(() {
      hasText.value = textController.text.trim().isNotEmpty;
    });
  }

  /// 📡 WebSocket Connection
  void connectToSocket() {
    channel = IOWebSocketChannel.connect(Uri.parse('ws://10.10.11.28:8080'));

    // 🔥 Listen for incoming socket messages
    channel.stream.listen(
          (data) {
        messageList.add(MessageModel(text: data.toString(), isMe: false));
        _scrollToBottom();
      },
      onError: (error) {
        print("❌ Socket Error: $error");
      },
      onDone: () {
        print("🔌 Disconnected from WebSocket");
      },
    );
  }

  /// 📝 Send text message
  void sendMessage() {
    final text = textController.text.trim();
    if (text.isEmpty) return;

    // Add my message to UI
    messageList.add(MessageModel(text: text, isMe: true));
    _scrollToBottom();

    // Send via socket
    channel.sink.add(text);

    textController.clear();
    hasText.value = false; // reset button state

    /// 🧪 Demo reply for UI testing
    Future.delayed(const Duration(milliseconds: 300), () {
      messageList.add(MessageModel(
        text: "Demo reply to: $text",
        isMe: false,
      ));
      _scrollToBottom();
    });
  }

  /// 🖼️ Send image message
  void sendImageMessage(String imagePath) {
    messageList.add(MessageModel(imageUrl: imagePath, isMe: true));
    _scrollToBottom();

    // Optionally send image URL/path to socket if backend supports
    // channel.sink.add("image:$imagePath");

    /// 🧪 Demo reply for UI testing
    Future.delayed(const Duration(seconds: 1), () {
      messageList.add(MessageModel(
        text: "Nice picture 👍",
        isMe: false,
      ));
      _scrollToBottom();
    });
  }

  /// 📷 Pick from gallery
  Future<void> pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      sendImageMessage(image.path);
    }
  }

  /// 🔽 Scroll to bottom after each new message
  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  /// ❌ Close socket safely
  @override
  void onClose() {
    channel.sink.close();
    super.onClose();
  }
}
