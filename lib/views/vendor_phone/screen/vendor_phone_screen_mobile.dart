part of 'vendor_phone_screen.dart';

class VendorPhoneScreenMobile extends GetView<VendorPhoneController> {
  const VendorPhoneScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
          children: [
            // Add your widgets here
            TextWidget(
              'Welcome Back ',
              fontWeight: FontWeight.bold,
              fontSize: Dimensions.titleLarge,
            ),
            Space.height.betweenInputBox, Space.height.betweenInputBox,
            Space.height.betweenInputBox, Space.height.betweenInputBox,
            SvgPicture.asset(Assets.dummy.phone),

            Space.height.betweenInputBox,
            PrimaryInputFieldWidget(
              label: "Contact Number",
              keyBoardType: TextInputType.number,
              controller: controller.numberController,
              hintText: "Enter your number",
            ),
            Space.height.betweenInputBox,
            Space.height.betweenInputBox,

            PrimaryButtonWidget(
              title: 'Continue',
              onPressed: () => Get.toNamed(Routes.registerScreen),
            ),
          ],
        ),
      ),
    );
  }
}
