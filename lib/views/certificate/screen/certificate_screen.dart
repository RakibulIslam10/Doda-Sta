import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/widgets/auth_app_bar.dart';
import 'package:doda_work/core/utils/extensions.dart';
import '../controller/certificate_controller.dart';

part 'certificate_screen_mobile.dart';

class CertificateScreen extends GetView<CertificateController> {
  const CertificateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: CertificateScreenMobile());
  }
}
