import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:web_socket_channel/io.dart';
import '../model/send_message_model.dart';

class InboxController extends GetxController {
  final messageList = <MessageModel>[].obs;

  final textController = TextEditingController();
  final scrollController = ScrollController();

  final hasText = false.obs;
  final hasTextOrImage = false.obs;

  final ImagePicker _picker = ImagePicker();

  late IOWebSocketChannel channel;

  @override
  void onInit() {
    super.onInit();
    connectToSocket();

    textController.addListener(() {
      hasText.value = textController.text.trim().isNotEmpty;
      hasTextOrImage.value = hasText.value;
    });
  }

  void connectToSocket() {
    channel = IOWebSocketChannel.connect(Uri.parse('ws://10.10.11.28:8080'));

    channel.stream.listen(
      (data) {
        messageList.add(
          MessageModel(text: data.toString(), isMe: false, time: _getTime()),
        );
        _scrollToBottom();
      },
      onError: (error) => print("Socket Error: $error"),
      onDone: () => print("Disconnected from WebSocket"),
    );
  }

  void sendMessage() {
    final text = textController.text.trim();
    if (text.isEmpty) return;

    messageList.add(MessageModel(text: text, isMe: true, time: _getTime()));
    _scrollToBottom();

    channel.sink.add(text);

    textController.clear();
    hasText.value = false;
    hasTextOrImage.value = false;

    /// Demo reply
    Future.delayed(const Duration(milliseconds: 300), () {
      messageList.add(
        MessageModel(
          text: "Demo reply to: $text",
          isMe: false,
          time: _getTime(),
        ),
      );
      _scrollToBottom();
    });
  }

  Future<void> pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) sendImageMessage(image.path);
  }

  void sendImageMessage(String imagePath) {
    messageList.add(
      MessageModel(imageUrl: imagePath, isMe: true, time: _getTime()),
    );
    _scrollToBottom();

    /// Demo reply
    Future.delayed(const Duration(seconds: 1), () {
      messageList.add(
        MessageModel(text: "Nice picture 👍", isMe: false, time: _getTime()),
      );
      _scrollToBottom();
    });
  }

  String _getTime() {
    final now = DateTime.now();
    return "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void onClose() {
    channel.sink.close();
    super.onClose();
  }
}
