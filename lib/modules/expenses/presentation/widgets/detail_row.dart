import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';

class DetailRow extends StatelessWidget {
  final String label;
  final String? value;
  final Widget? trailing;
  final bool isDescription;

  const DetailRow({
    required this.label,
    this.value,
    this.trailing,
    this.isDescription = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: context.theme.fonts.textMdRegular.copyWith(
                color: context.theme.colors.textSecondary,
              ),
            ),
          ),
          if (!isDescription) ...[
            if (trailing != null)
              trailing!
            else
              Expanded(
                child: Text(
                  value ?? '-',
                  textAlign: TextAlign.end,
                  style: context.theme.fonts.textMdMedium,
                ),
              ),
          ],
        ],
      ),
    );
  }
}
