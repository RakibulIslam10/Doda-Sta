import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../core/utils/basic_import.dart';
import '../core/utils/extensions.dart';

class DatePickerWidget extends StatefulWidget {
  final String hint;
  final String? label;
  final DateTime? initialDate;
  final DateTime? minDate;
  final Function(DateTime) onDateSelected;

  const DatePickerWidget({
    super.key,
    this.hint = "Select Date",
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
  final DateFormat _formatter = DateFormat("EEE, MMM dd yyyy");

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime firstDate = widget.minDate ?? now;
    DateTime tempDate = _selectedDate ?? firstDate;

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
                      setState(() => _selectedDate = tempDate);
                      widget.onDateSelected(tempDate);
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
                mode: CupertinoDatePickerMode.date,
                initialDateTime: tempDate,
                minimumDate: firstDate,
                maximumDate: DateTime(2100),
                onDateTimeChanged: (DateTime newDate) {
                  tempDate = newDate;
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
          widget.label ?? "Select Date",
          fontSize: Dimensions.titleSmall,
          fontWeight: FontWeight.w500,
          color: CustomColors.blackColor.withAlpha(888),
        ),
        InkWell(
          onTap: () => _pickDate(context),
          borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
          child: Container(
            padding: Dimensions.defaultHorizontalSize.edgeHorizontal * 0.5,
            height: Dimensions.inputBoxHeight * 0.7,
            decoration: BoxDecoration(
              border: Border.all(
                color: _selectedDate == null
                    ? CustomColors.disableColor
                    : CustomColors.primary,
                width: 1.4,
              ),
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
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