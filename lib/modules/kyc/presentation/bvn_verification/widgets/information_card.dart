import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:defifundr_mobile/core/utils/resolve_color.dart';

class InformationCard extends StatelessWidget {
  final String title;

  const InformationCard({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final Color textColor = context.theme.colors.textSecondary;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: resolveColor(
          context: context,
          lightColor: AppColors.bgB1Base,
          darkColor: AppColorDark.bgB1Base,
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: context.theme.colors.strokeSecondary,
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: context.theme.fonts.textMdSemiBold),
          const SizedBox(height: 8),
          _bulletPoint("Full name", textColor),
          _bulletPoint("Phone number", textColor),
          _bulletPoint("Date of Birth", textColor),
          const SizedBox(height: 8),
          Text(
            "Your BVN does not give us access to your bank account or transactions.",
            style: context.theme.fonts.textSmRegular.copyWith(
              color: textColor,
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              style: context.theme.fonts.textSmRegular.copyWith(
                color: textColor,
              ),
              children: [
                const TextSpan(text: "Dial "),
                TextSpan(
                  text: "*565*0#",
                  style: context.theme.fonts.textSmBold.copyWith(
                    color: context.theme.colors.brandDefault,
                  ),
                ),
                const TextSpan(
                    text: " on your registered number to get your BVN."),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bulletPoint(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Row(
        children: [
          Text("• ", style: TextStyle(color: color, fontSize: 14)),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: color, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
