import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/languages/strings.dart';
import '../core/themes/token.dart';
import '../core/utils/basic_import.dart';
import '../widgets/text_widget.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/languages/strings.dart';
import '../core/themes/token.dart';
import '../core/utils/basic_import.dart';
import '../widgets/text_widget.dart';

class PrimaryInputFieldWidget extends StatefulWidget {
  final String hintText;
  final String? label;
  final bool isPassword;
  final bool isEmail;
  final String? optionalText;
  final TextInputType? keyBoardType;
  final String? Function(String?)? validatorLogic;
  final bool readOnly;
  final Color? fillColor;

  final TextEditingController controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final int maxLines;

  const PrimaryInputFieldWidget({
    super.key,
    this.label,
    this.isPassword = false,
    this.isEmail = false,
    required this.controller,
    this.focusNode,
    this.nextFocusNode,
    this.maxLines = 1,
    this.keyBoardType,
    this.validatorLogic,
    this.readOnly = false,
    this.optionalText,
    this.fillColor,
    required this.hintText,
  });

  @override
  State<PrimaryInputFieldWidget> createState() =>
      _PrimaryInputFieldWidgetState();
}

class _PrimaryInputFieldWidgetState extends State<PrimaryInputFieldWidget> {
  bool _obscureText = true;

  String? _validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return Strings.pleaseFillOutTheField;
    }
    if (widget.isEmail) {
      final emailRegex = RegExp(r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$');
      if (!emailRegex.hasMatch(value.trim())) {
        return "Enter a valid email";
      }
    }
    if (widget.isPassword) {
      if (value.length < 6) {
        return "Password must be at least 6 characters";
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Label above input
        if (widget.label != null)
          Padding(
            padding: EdgeInsets.only(
              bottom: Dimensions.spaceBetweenInputTitleAndBox * 0.6,
            ),
            child: Row(
              children: [
                TextWidget(
                  widget.label!,
                  fontSize: Dimensions.titleMedium,
                  fontWeight: FontWeight.w500,
                  color: CustomColors.blackColor,
                ),
                if (widget.optionalText?.isNotEmpty ?? false)
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.widthSize * 0.5),
                    child: TextWidget(
                      widget.optionalText!,
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
          controller: widget.controller,
          focusNode: widget.focusNode,
          obscureText: widget.isPassword ? _obscureText : false,
          maxLines: widget.maxLines,
          cursorColor: CustomColors.primary,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: _validate,
          textInputAction: widget.nextFocusNode != null
              ? TextInputAction.next
              : TextInputAction.done,
          onFieldSubmitted: (_) {
            if (widget.nextFocusNode != null) {
              FocusScope.of(context).requestFocus(widget.nextFocusNode);
            } else {
              FocusScope.of(context).unfocus();
            }
          },
          readOnly: widget.readOnly,

          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: CustomStyle.bodyMedium.copyWith(
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w400,
              fontSize: Dimensions.titleMedium,
            ),

            /// Only show toggle when password
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: CustomColors.disableColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,

            filled: widget.fillColor != null,
            fillColor:
                widget.fillColor ?? Theme.of(context).colorScheme.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: CustomColors.primary, width: 1.4),
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: CustomColors.disableColor,
                width: 1.4,
              ),
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: CustomColors.rejected, width: 1.4),
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: CustomColors.rejected, width: 1.4),
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
            ),
          ),
        ),
      ],
    );
  }
}
