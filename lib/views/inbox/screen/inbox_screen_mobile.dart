part of 'inbox_screen.dart';

class InboxScreenMobile extends GetView<InboxController> {
  const InboxScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsetsGeometry.only(
            top: Dimensions.verticalSize * 0.5,
            bottom: Dimensions.heightSize * 0.8,
          ),
          child: TypeMessageWidget(),
        ),
      ),
      appBar: CommonAppBar(title: 'Chat'),
      body: SafeArea(child: SafeArea(child: ChatBodyWidget())),
    );
  }
}
