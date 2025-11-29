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

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      String formatted = picked.format(context);

      setState(() {
        selectedTime = formatted;
      });

      if (widget.onTimeSelected != null) {
        widget.onTimeSelected!(formatted);
      }
    }
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

        /// Tap-able Box
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
