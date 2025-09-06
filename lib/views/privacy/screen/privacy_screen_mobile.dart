part of 'privacy_screen.dart';

class PrivacyScreenMobile extends GetView<PrivacyController> {
  const PrivacyScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: 'Privacy Policy'),
      body: SafeArea(
        child: ListView(
          padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
          children: [
            
          ],
        ),
      ),
    );
  }
}
