import '../../../core/utils/basic_import.dart';
import '../../../core/utils/extensions.dart';
import 'package:intl/intl.dart';

class CustomDatePick extends StatefulWidget {
  final String hint;
  final String? label;
  final DateTime? initialDate;
  final Function(DateTime) onDateSelected;

  const CustomDatePick({
    super.key,
    this.hint = "Select Date",
    this.initialDate,
    required this.onDateSelected,
    this.label,
  });

  @override
  State<CustomDatePick> createState() => _CustomDatePickState();
}

class _CustomDatePickState extends State<CustomDatePick> {
  DateTime? _selectedDate;
  final DateFormat _formatter = DateFormat("yyyy-MM-dd");

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  @override
  void didUpdateWidget(CustomDatePick oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialDate != oldWidget.initialDate &&
        widget.initialDate != null) {
      setState(() {
        _selectedDate = widget.initialDate;
      });
    }
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: CustomColors.primary,
              onPrimary: Colors.white,
              surface: CustomColors.whiteColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: CustomColors.primary,
              ),
            ),
            dialogTheme: DialogThemeData(
              backgroundColor: CustomColors.whiteColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
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
            height: Dimensions.inputBoxHeight * 0.85,
            decoration: BoxDecoration(
              border: Border.all(
                color: _selectedDate == null
                    ? CustomColors.grayShade
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
                    color: Colors.black.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(Icons.calendar_today, color: CustomColors.grayShade,size: 20.sp,),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
