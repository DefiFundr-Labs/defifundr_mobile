import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/themes/color_scheme.dart';
import 'package:flutter/material.dart';

class SelectAccountType extends StatelessWidget {
  final String title;
  final String description;
  final String value;
  final ValueNotifier<String> groupValueNotifier;
  final Function(String) onSelectionChanged;

  const SelectAccountType({
    super.key,
    required this.title,
    required this.description,
    required this.value,
    required this.groupValueNotifier,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      width: 358,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: AppColors.white100),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Config.h2(context).copyWith(fontSize: 14),
                ),
                SizedBox(
                  height: 29,
                  child: ValueListenableBuilder<String>(
                    valueListenable: groupValueNotifier,
                    builder: (context, groupValue, _) {
                      return Radio<String>(
                        value: value,
                        groupValue: groupValue,
                        onChanged: (_) {
                          onSelectionChanged(value);
                          groupValueNotifier.value = value;
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                description,
                style: Config.h3(context).copyWith(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
