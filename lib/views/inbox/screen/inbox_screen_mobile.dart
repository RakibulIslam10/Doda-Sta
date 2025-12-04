import '../../../core/utils/app_storage.dart';
import '../../../core/utils/basic_import.dart';
import '../controller/inbox_controller.dart';

class InboxScreenMobile extends GetView<InboxController> {
  const InboxScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments ?? {};
    final participantNameArg = args["name"] ?? "User";
    final participantEmailArg = args["email"];
    final profileImageArg = args["profileImage"];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Obx(() {
              final profileImage = controller.participantProfile.value.isNotEmpty
                  ? "${ApiEndPoints.baseUrl}/${controller.participantProfile.value}"
                  : profileImageArg;

              final name = controller.participantName.value.isNotEmpty
                  ? controller.participantName.value
                  : participantNameArg;

              return CircleAvatar(
                radius: 20,
                backgroundImage:
                profileImage != null ? NetworkImage(profileImage) : null,
                backgroundColor: CustomColors.primary,
                child: profileImage == null
                    ? Text(
                  name[0].toUpperCase(),
                  style: const TextStyle(color: Colors.white),
                )
                    : null,
              );
            }),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  final name = controller.participantName.value.isNotEmpty
                      ? controller.participantName.value
                      : participantNameArg;
                  return Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }),
                if (participantEmailArg != null)
                  Text(
                    participantEmailArg,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),

      body: SafeArea(
    child: RefreshIndicator(
    color: CustomColors.primary,
      onRefresh: () async {
        if (controller.conversationId != null) {
          await controller.fetchConversation(controller.conversationId!);
        }
      },
      child: Obx(() {
        if (controller.messagesLists.isEmpty) {
          return ListView(
            children: const [
              SizedBox(height: 100),
              Center(child: Text("No messages yet")),
            ],
          );
        }

        return ListView.builder(
          controller: controller.scrollController,
          reverse: false, // Oldest at top, newest at bottom
          padding: const EdgeInsets.only(bottom: 10, top: 10),
          itemCount: controller.messagesLists.length,
          itemBuilder: (context, index) {
            final msg = controller.messagesLists[index];
            final isMe = msg["senderId"] == AppStorage.uId;

            return Align(
              alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
              child: GestureDetector(
                onLongPress: () {
                  final time = msg["time"] ?? "";
                  Get.snackbar(
                    "Sent at",
                    time,
                    snackPosition: SnackPosition.BOTTOM,
                    duration: const Duration(seconds: 2),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: isMe ? CustomColors.primary : Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: msg["image"] != null && msg["image"].isNotEmpty
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      "${ApiEndPoints.baseUrl}/${msg["image"]}",
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  )
                      : Text(
                    msg["textMsg"] ?? "",
                    style: TextStyle(
                      color: isMe ? Colors.white : Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    ),
    ),


    bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 20),
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.image, color: CustomColors.primary),
              onPressed: () => controller.pickImageFromGallery(),
            ),
            Expanded(
              child: TextField(
                controller: controller.textController,
                decoration: InputDecoration(
                  hintText: "Type a message...",
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
            IconButton(
              icon: const Icon(Icons.send, color: CustomColors.primary),
              onPressed: controller.sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
