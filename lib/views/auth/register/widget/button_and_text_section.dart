import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/routes/routes.dart';
import '../controller/register_controller.dart';

class ButtonAndTextSectionView extends GetView<RegisterController> {
  const ButtonAndTextSectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Space.height.v20,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: Obx(
                () => Checkbox(
                  activeColor: CustomColors.primary,
                  side: BorderSide(
                    color: CustomColors.disableColor,
                    width: 1.4,
                  ),
                  value: controller.isCheck.value,
                  onChanged: (value) {
                    controller.isCheck.value = !controller.isCheck.value;
                    controller.isError.value = false; // reset error
                  },
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                return Transform.translate(
                  key: ValueKey(controller.isError.value),
                  offset: controller.isError.value
                      ? const Offset(10, 0)
                      : Offset.zero,
                  child: TextWidget(
                    onTap: () {
                      controller.isCheck.value = !controller.isCheck.value;
                      controller.isError.value = false;
                    },
                    padding: EdgeInsets.only(left: Dimensions.widthSize),
                    "I have read and agree to dodawork's Terms and Conditions and Policy.",
                    maxLines: 2,
                    fontSize: Dimensions.titleSmall * 0.9,
                    color: controller.isError.value ? Colors.red : Colors.grey,
                  ),
                );
              }),
            ),
          ],
        ),
        Space.height.v20,
        PrimaryButtonWidget(
          title: "Next",
          onPressed: () {
            if (controller.fromKey.currentState!.validate()) {
              if (controller.isCheck.value) {
                Get.toNamed(Routes.verifyScreen);
              } else {
                controller.isError.value = true;
                CustomSnackBar.error('Check the term and conditions');
              }
            }
          },
        ),
      ],
    );
  }
}
