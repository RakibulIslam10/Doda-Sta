import 'package:doda_work/core/utils/extensions.dart';
import 'package:intl/intl.dart';

import '../core/utils/basic_import.dart';
import '../core/utils/function.dart';

class DatePickerWidget extends StatefulWidget {
  final String hint;
  final String? label;
  final DateTime? initialDate;
  final DateTime? minDate;
  final Function(DateTime) onDateSelected;

  const DatePickerWidget({
    super.key,
    this.hint = "Select Date & Time",
    this.initialDate,
    this.minDate,
    required this.onDateSelected,
    this.label,
  });

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime? _selectedDate;
  final DateFormat _formatter = DateFormat("yyyy-MM-dd");

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  Future<void> _pickDate(BuildContext context) async {
    if(widget.minDate == null) return;
    final picked = await pickDateTime(
      context: context,
      minTime: widget.minDate,
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
      widget.onDateSelected(picked);
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
          widget.label ?? "Select Date & Time",
          fontSize: Dimensions.titleSmall,
          fontWeight: FontWeight.w500,
          color: CustomColors.blackColor.withAlpha(888),
        ),
        InkWell(
          onTap: () => _pickDate(context),
          borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
          child: Container(
            padding:
            Dimensions.defaultHorizontalSize.edgeHorizontal * 0.5,
            height: Dimensions.inputBoxHeight * 0.7,
            decoration: BoxDecoration(
              border: Border.all(
                color: _selectedDate == null
                    ? CustomColors.disableColor
                    : CustomColors.primary,
                width: 1.4,
              ),
              borderRadius:
              BorderRadius.circular(Dimensions.radius * 0.8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextWidget(
                    _selectedDate == null
                        ? widget.hint
                        : _formatter.format(_selectedDate!),
                    fontSize: Dimensions.titleSmall,
                    color: _selectedDate == null
                        ? CustomColors.disableColor
                        : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(
                  Icons.calendar_today,
                  color: _selectedDate == null
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