import 'package:doda_work/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/layout.dart';
import '../controller/document_controller.dart';

part 'document_screen_mobile.dart';

class DocumentScreen extends GetView<DocumentController> {
  const DocumentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(mobile: DocumentScreenMobile());
  }
}
