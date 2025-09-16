part of '../screen/request_screen.dart';

class TimeAndDateSectionWidget extends GetView<RequestController> {
  const TimeAndDateSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        TextWidget(
          fontSize: Dimensions.titleSmall,

          'Preferred date and time for service',
          padding: Dimensions.heightSize.edgeBottom * 0.4,
        ),
        Row(
          children: [
            Expanded(
              child: DatePickerWidget(
                hint: "Select date",
                label: "Start Date",
                onDateSelected: (selected) {
                  controller.startDate.value = DateFormat(
                    'dd-MM-yyy',
                  ).format(selected);
                },
              ),
            ),
            Space.width.v10,
            Expanded(
              child: DatePickerWidget(
                hint: "Select date",
                label: "End Date",
                onDateSelected: (selected) {
                  controller.endDate.value = DateFormat(
                    'dd-MM-yyy',
                  ).format(selected);
                },
              ),
            ),
          ],
        ),
        Space.height.betweenInputBox,
        // TextWidget(
        //   'Service Date Range',
        //   fontSize: Dimensions.titleSmall,
        //   padding: Dimensions.heightSize.edgeBottom * 0.4,
        // ),
        Row(
          children: [
            Expanded(
              child: TimePickerWidget(
                label: 'Start Time',
                onTimeSelected: (time) {
                  controller.startedTime.value = time;
                },
              ),
            ),
            Space.width.v10,
            Expanded(
              child: TimePickerWidget(
                label: 'End Time',
                onTimeSelected: (time) {
                  controller.endTime.value = time;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
