import 'package:doda_work/core/themes/token.dart';
import 'package:doda_work/views/register/controller/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/space.dart';
import '../../../widgets/primary_button_widget.dart';
import '../../../widgets/text_widget.dart';

class ButtonAndTextSectionView extends GetView<RegisterController> {
  const ButtonAndTextSectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Space.height.v20,
        Row(
          crossAxisAlignment: crossStart,
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
                  },
                ),
              ),
            ),
            Expanded(
              child: TextWidget(
                padding: EdgeInsetsGeometry.only(left: Dimensions.widthSize),
                "I have read and agree to dodawork's Terms and Conditions and Policy.",
                maxLines: 2,
                fontSize: Dimensions.titleSmall * 0.9,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        Space.height.v20,
        PrimaryButtonWidget(title: "Next", onPressed: () {
          if(controller.fromKey.currentState!.validate()){
            print('Work');
          }
        }),
      ],
    );
  }
}
