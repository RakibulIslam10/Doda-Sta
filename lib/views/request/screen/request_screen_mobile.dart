part of 'request_screen.dart';

class RequestScreenMobile extends GetView<RequestController> {
  const RequestScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: 'Add Request', isBack: false),

      body: SafeArea(
        child: ListView(
          padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
          children: [
            TimeAndDateSectionWidget(),
            Space.height.betweenInputBox,
            OthersFieldWidget(),
            Space.height.betweenInputBox,

            AddPhotoGrid(),
            Space.height.betweenInputBox,

            PrimaryButtonWidget(
              title: "Submit",
              onPressed: () {
                Get.toNamed(Routes.summaryScreen);
              },
            ),

            Space.height.betweenInputBox,
          ],
        ),
      ),
    );
  }
}
