part of 'terms_screen.dart';

class TermsScreenMobile extends GetView<TermsController> {
  const TermsScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: 'Terms & Condition'),

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
