import 'dart:io';
import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/routes/routes.dart';
import 'package:doda_work/widgets/custom_drop_down_widget.dart';
import 'package:doda_work/widgets/date_picker_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../widgets/location_picker_widget.dart';
import '../../../widgets/time_picker_widget.dart';
import '../../category/controller/category_controller.dart';
import '../../navigation/controller/navigation_controller.dart';
import '../controller/request_controller.dart';
import 'package:intl/intl.dart';


part '../widget/time_and_date_section_widget.dart';

part '../widget/others_field_widget.dart';

part '../widget/add_photo_box_widget.dart';

part '../widget/request_info_card_widget.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  final controller = Get.find<RequestController>();
  final categoryController = Get.find<CategoryController>();
  final descriptionTextController = TextEditingController();
  final phoneTextController = TextEditingController();

  final fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        titleSpacing: 0,
        leadingWidth: 80,
        leading: GestureDetector(
          onTap: () => Get.find<NavigationController>().goToProfile(),
          child: Image.asset(Assets.logo.aaplogo.path, height: 50),
        ),
        title: TextWidget(
          'Book a Service Appointment',
          color: CustomColors.blackColor,
          fontSize: Dimensions.titleMedium,
          fontWeight: FontWeight.w400,
          maxLines: 2,
        ),
        actionsPadding: EdgeInsets.only(right: 8.0),
        actions: [
          GestureDetector(
            onTap: () => Get.toNamed(Routes.notificationScreen),
            child: Container(
              padding: EdgeInsets.all(Dimensions.paddingSize * 0.40),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: CustomColors.primary),
              ),
              child: SvgPicture.asset(Assets.icons.group),
            ),
          ),
          Space.width.v10,
        ],
      ),
      body: Form(
        key: fromKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          children: [
            TimeAndDateSectionWidget(),
            Space.height.betweenInputBox,
            OthersFieldWidget(
              controller: controller,
              requestController: descriptionTextController,
              phoneController: phoneTextController,
              categoryController: categoryController,
            ),
            Space.height.betweenInputBox,

            AddPhotoGrid(controller: controller),
            Space.height.betweenInputBox,

            Obx(() {
              return PrimaryButtonWidget(
                isLoading: controller.isLoading.value,
                title: "Submit",
                onPressed: () {
                  if (controller.selectedCategoryId.value.isEmpty) {
                    Get.snackbar(
                      "Missing Field",
                      "Please select a service category.",
                      backgroundColor: Colors.redAccent,
                      colorText: Colors.white,
                    );
                    return;
                  }

                  if (controller.selectedSubCategoryId.value.isEmpty) {
                    Get.snackbar(
                      "Missing Field",
                      "Please select a subcategory.",
                      backgroundColor: Colors.redAccent,
                      colorText: Colors.white,
                    );
                    return;
                  }

                  if (controller.selectedPriority.value.isEmpty) {
                    Get.snackbar(
                      "Missing Field",
                      "Please select a service priority.",
                      backgroundColor: Colors.redAccent,
                      colorText: Colors.white,
                    );
                    return;
                  }

                  if (controller.startDateTime.value == null ||
                      controller.endDateTime.value == null) {
                    Get.snackbar(
                      "Missing Field",
                      "Please select both start and end dates.",
                      backgroundColor: Colors.redAccent,
                      colorText: Colors.white,
                    );
                    return;
                  }

                  if (controller.selectedLatLng.value == null ||
                      controller.selectedAddress.value.isEmpty) {
                    Get.snackbar(
                      "Missing Location",
                      "Please select your service address.",
                      backgroundColor: Colors.redAccent,
                      colorText: Colors.white,
                    );
                    return;
                  }

                  if (controller.photos.isEmpty) {
                    Get.snackbar(
                      "Missing Image",
                      "Please add at least one photo of the issue.",
                      backgroundColor: Colors.redAccent,
                      colorText: Colors.white,
                    );
                    return;
                  }

                  if (fromKey.currentState!.validate()) {
                    controller.bookingService(
                      customerPhone: phoneTextController.text,
                      description: descriptionTextController.text,
                    );
                  }
                },
              );
            }),

            Space.height.betweenInputBox,
          ],
        ),
      ),
    );
  }
}
