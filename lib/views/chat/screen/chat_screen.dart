import 'package:doda_work/core/utils/basic_import.dart';
import '../controller/chat_controller.dart';
import 'chat_screen_mobile.dart';


class ChatScreen extends GetView<ChatController> {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: ChatScreenMobile());
  }
}
