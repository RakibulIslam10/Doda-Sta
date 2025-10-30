import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/core/utils/extensions.dart';

class TimePickerWidget extends StatefulWidget {
  final String label;
  final String? text;

  const TimePickerWidget({
    super.key,
    this.text,
    required this.label,
  });

  @override
  State<TimePickerWidget> createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        TextWidget(
          padding: EdgeInsetsGeometry.only(
            bottom: Dimensions.spaceBetweenInputTitleAndBox * 0.6,
          ),
          widget.label ?? "Select Time",
          fontSize: Dimensions.titleSmall,
          fontWeight: FontWeight.w500,
          color: CustomColors.blackColor.withAlpha(888),
        ),
        Container(
          padding: Dimensions.defaultHorizontalSize.edgeHorizontal * 0.5,
          height: Dimensions.inputBoxHeight * 0.7,
          decoration: BoxDecoration(
            border: Border.all(color: widget.text == null ? CustomColors.disableColor : CustomColors.primary, width: 1.4),
            borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                widget.text != null
                    ? widget.text ?? ""
                    : widget.label,
                fontSize: Dimensions.titleSmall,
                color: widget.text == null
                    ? CustomColors.disableColor
                    : Colors.black,
              ),
              Icon(Icons.access_time, color: widget.text == null ?CustomColors.disableColor : CustomColors.primary),
            ],
          ),
        ),
      ],
    );
  }
}
