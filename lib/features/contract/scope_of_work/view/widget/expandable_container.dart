import 'package:defifundr_mobile/core/constants/app_texts.dart';
import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/themes/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ExpandableContainer extends StatefulWidget {
  final String title;
  final String subtitle;
  final Widget content;

  const ExpandableContainer({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.content,
  }) : super(key: key);

  @override
  _ExpandableContainerState createState() => _ExpandableContainerState();
}

class _ExpandableContainerState extends State<ExpandableContainer> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Main Container (Title + Subtitle)
        Container(
          decoration: BoxDecoration(
            color: AppColors.white100,
            borderRadius: BorderRadius.circular(10),
            
          ),
          child: ListTile(
            title:Text(widget.title,
                style: Config.h2(context)
                    .copyWith(fontSize: 13, color: AppColors.titleBlack,fontWeight: FontWeight.w600)),
            subtitle: Text(widget.title,
                style: Config.h2(context)
                    .copyWith(fontSize: 9, color: AppColors.secondaryTextColor,fontWeight: FontWeight.w600)),
            trailing: 
              _isExpanded ? SvgPicture.asset(AppAssets.upArrow):SvgPicture.asset(AppAssets.downArrow),
            
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
          ),
        ),

        // Expanded Content (Appears separately with radius)
        if (_isExpanded)
          Padding(
            padding: const EdgeInsets.only(top: 13), // 13px gap
            child: Container(
              width: double.infinity, // Full width
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: widget.content,
            ),
          ),
      ],
    );
  }
}
