import '../../../core/utils/app_storage.dart';
import '../../../core/utils/basic_import.dart';
import '../../../core/utils/extensions.dart';
import '../../../routes/routes.dart';
import '../../navigation/controller/navigation_controller.dart';
import '../controller/chat_controller.dart';

class ChatScreenMobile extends StatelessWidget {
  ChatScreenMobile({super.key});

  // Inject ChatController
  final ChatController controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    final myId = AppStorage.userId;
    final myRole = AppStorage.role; // "USER" or "PROVIDER"

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        toolbarHeight: Dimensions.appBarHeight * 1.6,
        flexibleSpace: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.defaultHorizontalSize),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Get.find<NavigationController>().goToProfile(),
                  child: SvgPicture.asset(Assets.logo.appLogo, height: 45),
                ),
                TextWidget(
                  'Chat',
                  color: CustomColors.blackColor,
                  fontSize: Dimensions.titleMedium * 1.2,
                  fontWeight: FontWeight.w600,
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.notificationScreen),
                  child: Container(
                    margin: Dimensions.defaultHorizontalSize.edgeRight,
                    padding: EdgeInsets.all(Dimensions.paddingSize * 0.35),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: CustomColors.primary),
                    ),
                    child: SvgPicture.asset(Assets.icons.group),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: CustomColors.primary,
              ),
            );
          }

          if (controller.chatList.isEmpty) {
            return const Center(child: Text("No participants yet"));
          }

          return ListView.builder(
            itemCount: controller.chatList.length,
            itemBuilder: (context, index) {
              final chat = controller.chatList[index];

              // Get all participants except the logged-in user
              final participants = controller
                  .getAllParticipants(chat)
                  .where((p) => p.id != myId)
                  .toList();

              // If only participant is yourself, hide this chat
              if (participants.isEmpty) return const SizedBox.shrink();

              // Show only the first participant (1-on-1 chat)
              final participant = participants.last;

              return ListTile(
                onTap: () => controller.openConversation(chat),
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: CustomColors.primary,
                  backgroundImage: participant.profileImage != null
                      ? NetworkImage("http://your-base-url/${participant.profileImage}")
                      : null,
                  child: participant.profileImage == null
                      ? Text(
                    participant.name[0].toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  )
                      : null,
                ),
                title: Text(participant.name),
                subtitle: Text(participant.email ?? ""),
              );
            },
          );
        }),
      ),
    );
  }
}
