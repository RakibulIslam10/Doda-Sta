import 'package:cached_network_image/cached_network_image.dart';
import 'package:doda_work/core/themes/token.dart';
import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/core/utils/extensions.dart';
import 'package:doda_work/widgets/auth_app_bar.dart';
import 'package:doda_work/widgets/text_widget.dart';
import '../controller/chat_controller.dart';

part 'chat_screen_mobile.dart';

class ChatScreen extends GetView<ChatController> {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: ChatScreenMobile());
  }
}
