import 'package:flutter/cupertino.dart';
import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/core/utils/extensions.dart';

class TimePickerWidget extends StatefulWidget {
  final String label;
  final String? text;
  final Function(String)? onTimeSelected;

  const TimePickerWidget({
    super.key,
    this.text,
    required this.label,
    this.onTimeSelected,
  });

  @override
  State<TimePickerWidget> createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  String? selectedTime;

  @override
  void initState() {
    super.initState();
    selectedTime = widget.text;
  }

  @override
  void didUpdateWidget(covariant TimePickerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.text != oldWidget.text) {
      setState(() {
        selectedTime = widget.text;
      });
    }
  }

  Future<void> _pickTime() async {
    DateTime tempTime = DateTime.now();

    await showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 280.h,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: Dimensions.titleSmall,
                      ),
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      final hour = tempTime.hour;
                      final minute = tempTime.minute;
                      final period = hour >= 12 ? 'PM' : 'AM';
                      final displayHour = hour > 12
                          ? hour - 12
                          : hour == 0
                          ? 12
                          : hour;
                      final formatted =
                          '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';

                      setState(() => selectedTime = formatted);
                      widget.onTimeSelected?.call(formatted);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Done',
                      style: TextStyle(
                        color: CustomColors.primary,
                        fontSize: Dimensions.titleSmall,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: Colors.grey.shade200),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                initialDateTime: DateTime.now(),
                use24hFormat: false,
                onDateTimeChanged: (DateTime newTime) {
                  tempTime = newTime;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        TextWidget(
          padding: EdgeInsetsGeometry.only(
            bottom: Dimensions.spaceBetweenInputTitleAndBox * 0.6,
          ),
          widget.label,
          fontSize: Dimensions.titleSmall,
          fontWeight: FontWeight.w500,
          color: CustomColors.blackColor.withAlpha(888),
        ),
        GestureDetector(
          onTap: _pickTime,
          child: Container(
            padding: Dimensions.defaultHorizontalSize.edgeHorizontal * 0.5,
            height: Dimensions.inputBoxHeight * 0.7,
            decoration: BoxDecoration(
              border: Border.all(
                color: selectedTime == null
                    ? CustomColors.disableColor
                    : CustomColors.primary,
                width: 1.4,
              ),
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  selectedTime ?? widget.label,
                  fontSize: Dimensions.titleSmall,
                  color: selectedTime == null
                      ? CustomColors.disableColor
                      : Colors.black,
                ),
                Icon(
                  Icons.access_time,
                  color: selectedTime == null
                      ? CustomColors.disableColor
                      : CustomColors.primary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
