import '../../../core/utils/basic_import.dart';
import 'package:doda_work/core/utils/extensions.dart';

class MultiSelectDropDownWidget extends StatefulWidget {
  final String hint;
  final String? label;
  final List<String> items;
  final List<String>? initialValues;
  final Function(List<String>) onChanged;

  const MultiSelectDropDownWidget({
    super.key,
    this.hint = "Select Options",
    required this.items,
    this.initialValues,
    required this.onChanged,
    this.label,
  });

  @override
  State<MultiSelectDropDownWidget> createState() =>
      _MultiSelectDropDownWidgetState();
}

class _MultiSelectDropDownWidgetState extends State<MultiSelectDropDownWidget> {
  late List<String> _selectedValues;

  @override
  void initState() {
    super.initState();
    _selectedValues = widget.initialValues ?? [];
  }

  void _toggleValue(String value) {
    setState(() {
      if (_selectedValues.contains(value)) {
        _selectedValues.remove(value);
      } else {
        _selectedValues.add(value);
      }
    });
    widget.onChanged(_selectedValues);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: crossStart,
      children: [
        /// Label
        TextWidget(
          padding: EdgeInsetsGeometry.only(
            bottom: Dimensions.spaceBetweenInputTitleAndBox * 0.6,
          ),
          widget.label ?? "Select Category",
          fontSize: Dimensions.titleSmall,
          fontWeight: FontWeight.w500,
          color: CustomColors.blackColor.withAlpha(888),
        ),

        /// Selected chips
        if (_selectedValues.isNotEmpty)
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: _selectedValues
                .map((item) => Chip(
              label: TextWidget(item,
                  fontSize: Dimensions.titleSmall,
                  color: CustomColors.blackColor),
              backgroundColor: CustomColors.whiteColor,
              shape: StadiumBorder(
                side: BorderSide(color: CustomColors.primary, width: 1),
              ),
              deleteIcon: const Icon(Icons.close, size: 16),
              onDeleted: () => _toggleValue(item),
            ))
                .toList(),
          ).marginOnly(bottom: 8),

        /// Dropdown field
        Container(
          padding: Dimensions.defaultHorizontalSize.edgeHorizontal * 0.5,
          height: Dimensions.inputBoxHeight * 0.7,
          decoration: BoxDecoration(
            border: Border.all(
              color: _selectedValues.isEmpty
                  ? CustomColors.disableColor
                  : CustomColors.primary,
              width: 1.4,
            ),
            borderRadius: BorderRadius.circular(Dimensions.radius),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              dropdownColor: CustomColors.whiteColor,
              iconEnabledColor: _selectedValues.isEmpty
                  ? CustomColors.disableColor
                  : CustomColors.primary,
              value: null, // always null to allow multi select
              isExpanded: true,
              hint: TextWidget(
                widget.hint,
                color: Colors.grey,
                fontSize: width * 0.04,
              ),
              items: widget.items
                  .map(
                    (item) => DropdownMenuItem(
                  value: item,
                  child: Row(
                    children: [
                      Checkbox(
                        value: _selectedValues.contains(item),
                        activeColor: CustomColors.primary,
                        onChanged: (_) => _toggleValue(item),
                      ),
                      TextWidget(item,
                          fontSize: Dimensions.titleSmall,
                          color: CustomColors.blackColor),
                    ],
                  ),
                ),
              )
                  .toList(),
              onChanged: (value) {
                if (value != null) _toggleValue(value);
              },
            ),
          ),
        ),
      ],
    );
  }
}
