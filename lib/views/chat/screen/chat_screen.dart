import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/core/utils/extensions.dart';
import '../../../routes/routes.dart';
import '../../navigation/controller/navigation_controller.dart';
import '../controller/chat_controller.dart';

part 'chat_screen_mobile.dart';

class ChatScreen extends GetView<ChatController> {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: ChatScreenMobile());
  }
}
