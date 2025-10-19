import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/core/utils/extensions.dart';
import '../../../../routes/routes.dart';
import '../controller/login_controller.dart';

class ButtonSectionWidget extends GetView<LoginController> {
  const ButtonSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryButtonWidget(
          title: 'Sign in',
          onPressed: () {
            if (controller.formKey.currentState!.validate()) {
              Get.offAllNamed(Routes.navigationScreen);
            }
          },
        ),
        Space.height.v10,

        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            TextWidget(
              padding: Dimensions.widthSize.edgeLeft,
              'Don’t have an account?',
              color: CustomColors.secondaryDarkText,
              fontWeight: FontWeight.w400,
              fontSize: Dimensions.titleMedium * 0.96,
            ),
            TextWidget(
              padding: Dimensions.widthSize.edgeLeft,
              'Sign Up',
              onTap: () => Get.toNamed(Routes.registerScreen),
              color: CustomColors.primary,
              fontWeight: FontWeight.w500,
              fontSize: Dimensions.titleMedium * 0.96,
            ),
          ],
        ),
        TextWidget(
          'Or',
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w400,
        ),

        Container(
          margin: Dimensions.verticalSize.edgeVertical * 0.25,
          height: Dimensions.buttonHeight * 0.7,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius * 3),
            border: Border.all(color: CustomColors.primary, width: 1.4),
          ),

          child: Row(
            mainAxisAlignment: mainCenter,
            children: [
              SvgPicture.asset(Assets.logo.google),
              TextWidget(
                'Sign in with Google',
                padding: Dimensions.widthSize.edgeLeft,
              ),
            ],
          ),
        ),
        Container(
          margin: Dimensions.heightSize.edgeTop * 0.2,
          height: Dimensions.buttonHeight * 0.7,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius * 3),
            border: Border.all(color: CustomColors.primary, width: 1.4),
          ),

          child: Row(
            mainAxisAlignment: mainCenter,
            children: [
              SvgPicture.asset(Assets.logo.page1),
              TextWidget(
                'Sign in with Apple',
                padding: Dimensions.widthSize.edgeLeft,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
