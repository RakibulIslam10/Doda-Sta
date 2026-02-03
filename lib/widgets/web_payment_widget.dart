import 'package:doda_work/views/home_vendor/controller/home_vendor_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/routes.dart';
import '../../../widgets/custom_snackbar.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'auth_app_bar.dart';
import 'loading_widget.dart';

class WebPaymentScreen extends StatefulWidget {
  const WebPaymentScreen({super.key});

  @override
  State<WebPaymentScreen> createState() => _WebPaymentScreenState();
}
class _WebPaymentScreenState extends State<WebPaymentScreen> {
  final controller = Get.find<HomeVendorController>();
  late final WebViewController _webViewController;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    // ✅ paymentUrl check করুন
    final paymentUrl = controller.paymentUrl.value;

    if (paymentUrl.isEmpty) {
      _handleFailure("Payment URL not found");
      return;
    }

    debugPrint("🔗 Loading Payment URL: $paymentUrl");

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() => isLoading = true);
          },
          onPageFinished: (String url) {
            setState(() => isLoading = false);
            debugPrint("✅ Current URL: $url");

            // ✅ Success check
            if (url.contains('success')) {
              _handleSuccess();
            }
            // ✅ Cancel/Failed check
            else if (url.contains('cancel') || url.contains('failed')) {
              _handleFailure("Payment failed or was cancelled");
            }
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint("❌ WebView Error: ${error.description}");
            _handleFailure("Failed to load payment page");
          },
        ),
      )
      ..loadRequest(Uri.parse(paymentUrl));

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Payment',
        isBack: true,
      ),
      body: isLoading
          ? const LoadingWidget()
          : WebViewWidget(controller: _webViewController),
    );
  }

  void _handleSuccess() {
    debugPrint("✅ Payment Successful");

    // ✅ paymentUrl reset করুন
    controller.paymentUrl.value = '';

    Get.offAllNamed(Routes.congratulationsScreen);
  }

  void _handleFailure(String message) {
    debugPrint("❌ Payment Failed: $message");

    // ✅ paymentUrl reset করুন
    controller.paymentUrl.value = '';

    Get.back();
    CustomSnackBar.error(message);
  }
}