part of 'onboard_screen.dart';

class OnboardScreenMobile extends GetView<OnboardController> {
  const OnboardScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: ''),
      body: SafeArea(
        child: Padding(
          padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
          child: Column(
            mainAxisAlignment: mainCenter,
            children: [
              Container(
                color: Colors.cyan,
                height: 400,
                child: PageView.builder(
                  itemCount: controller.onboardItemList.length,
                  physics: ClampingScrollPhysics(),


                  itemBuilder: (context, index) {
                  return Column(children: [
                  ],);
                },),
              )

            ],
          ),
        ),
      ),
    );
  }
}
