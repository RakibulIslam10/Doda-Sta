import 'package:doda_work/views/register/controller/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/space.dart';
import '../../../widgets/primary_input_widget.dart';

class FieldsSectionView extends GetView<RegisterController> {
  const FieldsSectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.fromKey,
      child: Column(
        children: [
          Space.height.v20,
          PrimaryInputFieldWidget(
            controller: controller.nameController,
            hintText: 'Enter your preferred name',
            label: 'Preferred Name',
            nextFocusNode: controller.emailFocus,
            requiredField: false,
          ),
          Space.height.betweenInputBox,
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
            nextFocusNode: controller.confirmPasswordFocus,
          ),

          Space.height.betweenInputBox,
          PrimaryInputFieldWidget(
            hintText: "Confirm your password",
            label: "Confirm Password",
            isPassword: true,
            controller: controller.passConfirmController,
            focusNode: controller.confirmPasswordFocus,
            nextFocusNode: null,
            confirmWith: controller.passwordController, // only checks matching
          ),
        ],
      ),
    );
  }
}
