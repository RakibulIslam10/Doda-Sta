part of '../screen/request_screen.dart';

class TimeAndDateSectionWidget extends GetView<RequestController> {
  const TimeAndDateSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        TextWidget(
          'Preferred Date and Time',
          fontSize: Dimensions.titleSmall,
          fontWeight: FontWeight.w500,
          color: CustomColors.blackColor.withAlpha(888),
        ),
        SizedBox(height: Dimensions.spaceBetweenInputTitleAndBox * 0.6),

        // ---------------- DATE SECTION ----------------
        Obx(() => Row(
            children: [
              Expanded(
                child: DatePickerWidget(
                  hint: "Select date",
                  label: "Start Date",
                  minDate: DateTime.now(),
                  initialDate: controller.startDateTime.value,
                  onDateSelected: (selected) {
                    controller.startDateTime.value = selected;
                    if (controller.endDateTime.value != null && controller.endDateTime.value!.isBefore(selected)) {
                      controller.endDateTime.value = null;
                    }
                  },
                ),
              ),
              Space.width.v10,
              Expanded(
                child: DatePickerWidget(
                  hint: "Select date",
                  label: "End Date",
                  minDate: controller.startDateTime.value,
                  initialDate: controller.endDateTime.value,
                  onDateSelected: (selected) {
                    controller.endDateTime.value = selected;
                  },
                ),
              ),
            ],
          ),
        ),

        Space.height.betweenInputBox,
        Obx((){
          final time = controller.startDateTime.value;
          final formattedTime = time != null ? DateFormat('hh:mm a').format(
            DateTime(2025, 1, 1, time.hour, time.minute),
          ) : null;

          final time1 = controller.endDateTime.value;
          final formattedTime1 = time1 != null ? DateFormat('hh:mm a').format(
            DateTime(2025, 1, 1, time1.hour, time1.minute),
          ) : null;

          return Row(
            children: [
              Expanded(
                child: TimePickerWidget(
                  label: 'Start Time',
                  text: formattedTime,
                ),
              ),
              Space.width.v10,
              Expanded(
                child: TimePickerWidget(
                  label: 'End Time',
                  text: formattedTime1,
                ),
              ),
            ],
          );
        },
        ),
      ],
    );
  }
}
