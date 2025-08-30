import 'package:doda_work/core/utils/extensions.dart';
import 'package:doda_work/widgets/text_widget.dart';

import '../core/languages/strings.dart';
import '../core/themes/token.dart';
import '../core/utils/basic_import.dart';
import 'custom_image_widget.dart';

class PrimaryInputField extends StatelessWidget {
  final double? radius;
  final Color? borderColor;
  final TextEditingController controller;
  final int? maxLines;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final TextInputType? keyBoardType;
  final String? Function(String?)? validatorLogic;
  final bool autofocus;
  final bool isPasswordField;
  final bool isEmailValidator;
  final String hintTex;
  final String? optionalText;
  final String? label;
  final bool readOnly;
  final Color? fillColor;

  const PrimaryInputField({
    super.key,
    this.radius,
    this.borderColor,
    required this.controller,
    this.maxLines,
    this.keyBoardType,
    this.validatorLogic,
    this.focusNode,
    this.nextFocusNode,
    this.autofocus = false,
    this.isPasswordField = false,
    required this.hintTex,
    this.isEmailValidator = false,
    this.readOnly = false,
    this.optionalText,
    this.label,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (label != null)
          Padding(
            padding: EdgeInsets.only(
              bottom: Dimensions.spaceBetweenInputTitleAndBox * 0.8,
            ),
            child: Row(
              children: [
                TextWidget(
                  label!,
                  fontSize: Dimensions.titleMedium,
                  style: CustomStyle.labelSmall.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  color: CustomColors.whiteColor,
                ),
                if (optionalText?.isNotEmpty ?? false)
                  Padding(
                    padding: Dimensions.horizontalSize.edgeHorizontal * 0.25,
                    child: TextWidget(
                      optionalText!,
                      fontSize: Dimensions.titleMedium * 0.9,
                      style: CustomStyle.labelSmall.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                      color: CustomColors.primary,
                    ),
                  ),
              ],
            ),
          ),
        TextFormField(
          readOnly: readOnly,
          cursorColor: CustomColors.primary,
          controller: controller,
          maxLines: maxLines ?? 1,
          focusNode: focusNode,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: keyBoardType,

          textInputAction: nextFocusNode != null
              ? TextInputAction.next
              : TextInputAction.done,

          validator:
          validatorLogic ??
                  (value) {
                if (value == null || value.trim().isEmpty) {
                  return Strings.pleaseFillOutTheField;
                }
                // Optional email validation
                if (isEmailValidator == true) {
                  final emailRegex = RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  );
                  if (!emailRegex.hasMatch(value.trim())) {
                    return "Invalid email address";
                  }
                }

                return null; // valid
              },
          onFieldSubmitted: (_) {
            nextFocusNode?.requestFocus();
          },

          autofocus: autofocus,
          obscureText: isPasswordField == true ? true : false,

          // autofocus: false,
          decoration: InputDecoration(
            isDense: true,
            hintText: hintTex,
            filled: fillColor != null ? true : false,
            fillColor: fillColor ?? Theme.of(context).colorScheme.tertiary,
            hintStyle: CustomStyle.bodyMedium.copyWith(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),

            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor ?? CustomColors.secondary,
              ),
              borderRadius: BorderRadius.circular(
                radius ?? Dimensions.radius * 0.8,
              ),
            ),

            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor ?? CustomColors.secondary,
              ),
              borderRadius: BorderRadius.circular(
                radius ?? Dimensions.radius * 0.8,
              ),
            ),

            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: CustomColors.rejected, width: 1.1),
              borderRadius: BorderRadius.circular(
                radius ?? Dimensions.radius * 0.8,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: CustomColors.primary, width: 1.1),
              borderRadius: BorderRadius.circular(
                radius ?? Dimensions.radius * 0.8,
              ),
            ),

            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: CustomColors.rejected, width: 1.1),
              borderRadius: BorderRadius.circular(
                radius ?? Dimensions.radius * 0.8,
              ),
            ),
          ),
        ),
      ],
    );
  }
}