part of 'login_screen.dart';

class LoginScreenMobile extends GetView<LoginController> {
  const LoginScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            children: [
              Container(
                margin: EdgeInsetsGeometry.only(
                  top: Dimensions.verticalSize * 2,
                  bottom: Dimensions.heightSize,
                ),
                padding: Dimensions.widthSize.edgeHorizontal,
                height: Dimensions.buttonHeight * 0.7,
                decoration: BoxDecoration(
                  color: CustomColors.primary,
                  borderRadius: BorderRadius.circular(Dimensions.radius),
                ),
                child: Row(
                  mainAxisSize: mainMin,
                  mainAxisAlignment: mainSpaceBet,
                  children: [
                    CircleAvatar(),
                    TextWidget(
                      "Canada",
                      padding: EdgeInsetsGeometry.symmetric(
                        horizontal: Dimensions.widthSize,
                      ),
                      color: CustomColors.whiteColor,
                      fontSize: Dimensions.labelLarge * 1.2,
                    ),

                    Icon(
                      Icons.keyboard_arrow_down_outlined,
                      size: Dimensions.iconSizeLarge,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              TextWidget(
                "Join Us",
                color: CustomColors.primary,
                fontSize: Dimensions.titleLarge * 0.9,
              ),

              AnimatedContainer(
                margin: EdgeInsetsGeometry.symmetric(
                  horizontal: Dimensions.defaultHorizontalSize,
                  vertical: Dimensions.verticalSize * 0.8,
                ),
                decoration: BoxDecoration(
                  color: CustomColors.whiteColor,
                  border: Border.all(color: CustomColors.primary, width: 1.8),
                  borderRadius: BorderRadius.circular(Dimensions.radius * 3),
                ),
                height: Dimensions.buttonHeight * 0.7,
                width: double.infinity,

                duration: const Duration(milliseconds: 300),

                child: Row(
                  mainAxisAlignment: mainCenter,
                  children: [
                    Icon(
                      Icons.person,
                      size: Dimensions.iconSizeLarge,
                      color: CustomColors.primary,
                    ),
                    TextWidget(
                      padding: EdgeInsetsGeometry.symmetric(
                        horizontal: Dimensions.widthSize,
                      ),
                      'As A Client',
                      fontWeight: FontWeight.bold,
                      fontSize: Dimensions.titleMedium * 1.2,
                      color: CustomColors.primary,
                    ),
                    Icon(Icons.arrow_forward_ios, color: CustomColors.primary),
                  ],
                ),
              ),

              AnimatedContainer(
                margin: EdgeInsetsGeometry.symmetric(
                  horizontal: Dimensions.defaultHorizontalSize,
                ),
                decoration: BoxDecoration(
                  color: CustomColors.primary,
                  border: Border.all(color: CustomColors.primary, width: 1.8),
                  borderRadius: BorderRadius.circular(Dimensions.radius * 3),
                ),
                height: Dimensions.buttonHeight * 0.7,
                width: double.infinity,

                duration: const Duration(milliseconds: 300),

                child: Row(
                  mainAxisAlignment: mainCenter,
                  children: [
                    Icon(
                      Icons.person,
                      size: Dimensions.iconSizeLarge,
                      color: CustomColors.whiteColor,
                    ),
                    TextWidget(
                      padding: EdgeInsetsGeometry.symmetric(
                        horizontal: Dimensions.widthSize,
                      ),
                      'As A Client',
                      fontWeight: FontWeight.bold,
                      fontSize: Dimensions.titleMedium * 1.2,
                      color: CustomColors.whiteColor,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: CustomColors.whiteColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: CommonAppBar(title: ''),
      body: SafeArea(
        child: ListView(
          padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
          children: [
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                TextWidget(
                  'Welcome to ',
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.titleLarge,
                ),
                TextWidget(
                  'dodawork!',
                  color: CustomColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.titleLarge,
                ),
                Space.height.v40,
                Space.height.v40,
              ],
            ),
            Space.height.v40,
            SvgPicture.asset(Assets.dummy.mobileLoginRafiki1),
          ],
        ),
      ),
    );
  }
}
