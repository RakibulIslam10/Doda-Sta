

import 'package:doda_work/core/utils/app_storage.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../core/utils/basic_import.dart';
import '../../../widgets/auth_app_bar.dart';
import '../controller/inbox_controller.dart';

class InboxScreenMobile extends GetView<InboxController> {
  const InboxScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Chat',
        // Optionally, you can show participant names here if passed via arguments
        // title: Get.arguments != null ? Get.arguments['title'] : 'Chat',
      ),
      body: SafeArea(
        child: Column(
          children: [
            /// Chat messages list
            Expanded(
              child: Obx(
                    () {
                  final messages = controller.messageList;
                  if (messages.isEmpty) {
                    return const Center(
                      child: Text(
                        'No messages yet',
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }
                  return ListView.builder(
                    controller: controller.scrollController,
                    reverse: true, // Latest message at bottom
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[messages.length - 1 - index]; // reverse order
                      return Align(
                        alignment: message.isMe
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: message.isMe
                                ? CustomColors.primary
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: message.imageUrl != null
                              ? Image.network(
                            message.imageUrl!,
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          )
                              : Text(
                            message.text ?? '',
                            style: TextStyle(
                              color: message.isMe
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            /// Message input area
            SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: Dimensions.verticalSize * 0.5,
                ),
                color: Colors.white,
                child: Row(
                  children: [
                    /// Image picker button
                    IconButton(
                      icon: const Icon(Icons.image, color: CustomColors.primary),
                      onPressed: () => controller.pickImageFromGallery(),
                    ),

                    /// Text input
                    Expanded(
                      child: TextField(
                        controller: controller.textController,
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 0),
                        ),
                      ),
                    ),

                    /// Send button
                    Obx(
                          () => IconButton(
                        icon: Icon(
                          Icons.send,
                          color: controller.hasTextOrImage.value
                              ? CustomColors.primary
                              : Colors.grey,
                        ),
                        onPressed: controller.hasTextOrImage.value
                            ? () => controller.sendMessage()
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
