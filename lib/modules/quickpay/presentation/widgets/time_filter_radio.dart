import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/utils/resolve_color.dart';
import 'package:flutter/material.dart';

enum TimeRange { last7Days, last14Days, last30Days }

class TimeFilterRadio extends StatefulWidget {
  final TimeRange? initialSelection;
  final ValueChanged<TimeRange> onChanged;

  const TimeFilterRadio({
    Key? key,
    this.initialSelection,
    required this.onChanged,
  }) : super(key: key);

  @override
  _TimeFilterRadioState createState() => _TimeFilterRadioState();
}

class _TimeFilterRadioState extends State<TimeFilterRadio> {
  late TimeRange? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialSelection ?? TimeRange.last7Days;
  }

  void _handleRadioValueChange(TimeRange? value) {
    setState(() {
      _selectedValue = value;
    });
    if (value != null) {
      widget.onChanged(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: TimeRange.values.map((range) {
        return Column(
          children: [
            InkWell(
              onTap: () => _handleRadioValueChange(range),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _getLabelForRange(range),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter',
                      ),
                    ),
                    Spacer(),
                    CustomRadio<TimeRange>(
                      value: range,
                      groupValue: _selectedValue!,
                      onChanged: _handleRadioValueChange,
                      fillColor:
                          AppColors.brandDefault, // fill color when selected
                      borderColor: resolveColor(
                        context: context,
                        lightColor: AppColors.strokeSecondary,
                        darkColor: AppColorDark.strokeSecondary,
                      ), // border color always visible
                      size: 20,
                      borderRadius: 32,
                      borderWidth: 1,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8 * 3),
          ],
        );
      }).toList(),
    );
  }

  String _getLabelForRange(TimeRange range) {
    switch (range) {
      case TimeRange.last7Days:
        return 'Last 7 days';
      case TimeRange.last14Days:
        return 'Last 14 days';
      case TimeRange.last30Days:
        return 'Last 30 days';
    }
  }
}

class CustomRadio<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;
  final Color fillColor;
  final Color borderColor;
  final double size;
  final double borderRadius;
  final double borderWidth;

  const CustomRadio({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.fillColor,
    required this.borderColor,
    this.size = 20,
    this.borderRadius = 32,
    this.borderWidth = 1,
  }) : super(key: key);

  bool get _selected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: _selected ? fillColor : Colors.transparent,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: borderColor,
            width: borderWidth,
          ),
        ),
        child: _selected
            ? Center(
                child: Container(
                  width: size * 0.4, // 40% of the outer circle
                  height: size * 0.4,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(size * 0.2),
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
