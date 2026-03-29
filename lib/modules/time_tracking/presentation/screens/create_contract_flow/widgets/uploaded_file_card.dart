import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UploadedFileCard extends StatelessWidget {
  final String fileName;
  final VoidCallback onDelete;

  const UploadedFileCard({
    super.key,
    required this.fileName,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: context.theme.colors.bgB1,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.theme.colors.strokeSecondary),
      ),
      child: Row(
        children: [
          Icon(Icons.description_outlined,
              color: context.theme.colors.brandDefault, size: 22),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(fileName, style: context.theme.fonts.textSmMedium),
          ),
          GestureDetector(
            onTap: onDelete,
            child:
                const Icon(Icons.delete_outline, color: Colors.red, size: 22),
          ),
        ],
      ),
    );
  }
}
