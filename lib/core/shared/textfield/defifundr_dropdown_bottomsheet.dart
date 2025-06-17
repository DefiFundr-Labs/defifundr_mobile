import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefiFundrDropdownBottomSheet {
  static Future<void> show({
    required BuildContext context,
    required List<String> items,
    required Function(String selected) onItemSelected,
    String? title,
    double? maxHeightRatio,
  }) async {
    final theme = Theme.of(context);

    await showModalBottomSheet(
      context: context,
      backgroundColor: theme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title != null) ...[
                Text(
                  title,
                  style: theme.textTheme.titleMedium,
                ),
                SizedBox(height: 12.h),
              ],
              Flexible(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height *
                        (maxHeightRatio ?? (items.length > 8 ? 0.4 : 0.25)),
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: items.length,
                    separatorBuilder: (_, __) => Divider(
                      height: 1,
                      color: theme.dividerColor,
                    ),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return ListTile(
                        title: Text(
                          item,
                          style: theme.textTheme.bodyLarge,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          onItemSelected(item);
                        },
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        );
      },
    );
  }
}
