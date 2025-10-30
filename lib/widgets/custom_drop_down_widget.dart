import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/core/utils/extensions.dart';

class CustomDropDownWidget<T> extends StatefulWidget {
  final String hint;
  final String? label;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final ValueChanged<T?> onChanged;

  const CustomDropDownWidget({
    super.key,
    this.hint = "Select Option",
    required this.items,
    this.value,
    required this.onChanged,
    this.label,
  });

  @override
  State<CustomDropDownWidget<T>> createState() => _CustomDropDownWidgetState<T>();
}

class _CustomDropDownWidgetState<T> extends State<CustomDropDownWidget<T>> {
  T? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value;
  }

  @override
  void didUpdateWidget(covariant CustomDropDownWidget<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _selectedValue = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: crossStart,
      children: [
        if (widget.label != null)
          TextWidget(
            padding: EdgeInsetsGeometry.only(
              bottom: Dimensions.spaceBetweenInputTitleAndBox * 0.6,
            ),
            widget.label!,
            fontSize: Dimensions.titleSmall,
            fontWeight: FontWeight.w500,
            color: CustomColors.blackColor.withAlpha(888),
          ),
        Container(
          padding: Dimensions.defaultHorizontalSize.edgeHorizontal * 0.5,
          height: Dimensions.inputBoxHeight * 0.7,
          decoration: BoxDecoration(
            border: Border.all(
              color: _selectedValue == null
                  ? CustomColors.disableColor
                  : CustomColors.primary,
              width: 1.4,
            ),
            borderRadius: BorderRadius.circular(Dimensions.radius),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              dropdownColor: CustomColors.whiteColor,
              iconEnabledColor: _selectedValue == null
                  ? CustomColors.disableColor
                  : CustomColors.primary,
              value: _selectedValue,
              isExpanded: true,
              hint: TextWidget(
                widget.hint,
                color: Colors.grey,
                fontSize: width * 0.04,
              ),
              items: widget.items,
              onChanged: (value) {
                setState(() => _selectedValue = value);
                widget.onChanged(value);
              },
            ),
          ),
        ),
      ],
    );
  }
}
