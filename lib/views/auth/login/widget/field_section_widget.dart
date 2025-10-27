import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/core/utils/extensions.dart';
import 'package:doda_work/routes/routes.dart';
import 'package:shadify/shadify.dart';
import '../controller/login_controller.dart';

class FieldSectionWidget extends GetView<LoginController> {
  const FieldSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          PrimaryInputFieldWidget(
            label: "Email",
            isEmail: true,
            controller: controller.emailController,
            focusNode: controller.emailFocus,
            nextFocusNode: controller.passwordFocus,
            hintText: "Enter your email",
          ),

          Space.height.betweenInputBox,
          PrimaryInputFieldWidget(
            hintText: "Enter your password",
            label: "Password",
            isPassword: true,
            controller: controller.passwordController,
            focusNode: controller.passwordFocus,
            nextFocusNode: null,
          ),
          Space.height.v10,
          Row(
            mainAxisAlignment: mainSpaceBet,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Obx(
                      () => Checkbox(
                        activeColor: CustomColors.primary,
                        side: BorderSide(
                          color: CustomColors.disableColor,
                          width: 1.4,
                        ),
                        value: controller.rememberMe.value,
                        onChanged: (value) {
                          controller.rememberMe.value =
                              !controller.rememberMe.value;
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ),
                  TextWidget(
                    padding: Dimensions.widthSize.edgeLeft,
                    'Remember Me',
                    onTap: () => controller.rememberMe.value =
                        !controller.rememberMe.value,
                    fontWeight: FontWeight.w400,
                    fontSize: Dimensions.titleMedium,
                  ),
                ],
              ),
              TextWidget(
                onTap: () => Get.toNamed(Routes.forgotScreen),
                textAlign: TextAlign.end,
                "Forget Password",
                color: CustomColors.primary,
                fontWeight: FontWeight.w400,
                fontSize: Dimensions.titleMedium,
              ),
            ],
          ),
          Space.height.v20,
        ],
      ),
    );
  }
}
