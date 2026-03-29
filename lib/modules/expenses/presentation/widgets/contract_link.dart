import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/utils/ellipsify.dart';
import 'package:flutter/material.dart';

class ContractLink extends StatelessWidget {
  final String? name;

  const ContractLink({this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 160),
          child: Text(
            ellipsify(word: name ?? '-', maxLength: 17),
            style: context.theme.fonts.textMdMedium,
          ),
        ),
        const SizedBox(width: 6),
        Icon(Icons.open_in_new_rounded,
            size: 14, color: context.theme.colors.textSecondary),
      ],
    );
  }
}
