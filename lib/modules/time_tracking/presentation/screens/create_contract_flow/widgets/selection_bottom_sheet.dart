import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:defifundr_mobile/modules/finance/data/model/network.dart';
import 'package:defifundr_mobile/modules/finance/data/model/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectionBottomSheet extends StatefulWidget {
  final String title;
  final List<dynamic> items;
  final ValueChanged<dynamic> onSelected;
  final bool showSearch;
  final String? actionButtonText;
  final VoidCallback? onActionButtonPressed;
  final Widget Function(dynamic)? itemBuilder;

  const SelectionBottomSheet({
    Key? key,
    required this.title,
    required this.items,
    required this.onSelected,
    this.showSearch = false,
    this.actionButtonText,
    this.onActionButtonPressed,
    this.itemBuilder,
  }) : super(key: key);

  @override
  State<SelectionBottomSheet> createState() => _SelectionBottomSheetState();
}

class _SelectionBottomSheetState extends State<SelectionBottomSheet> {
  late List<dynamic> _filteredItems;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterItems(String query) {
    setState(() {
      _filteredItems = widget.items.where((item) {
        final text = (item is String)
            ? item
            : (item is Network
                ? item.name
                : (item is NetworkAsset ? item.name : ''));
        return text.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: context.theme.colors.bgB1,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: context.theme.colors.strokeSecondary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Text(widget.title,
                      style: context.theme.fonts.heading2Bold),
                ),
              ],
            ),
          ),
          if (widget.showSearch) ...[
            SizedBox(height: 12.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AppTextField(
                controller: _searchController,
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                prefixType: PrefixType.customIcon,
                onChanged: _filterItems,
              ),
            ),
          ],
          SizedBox(height: 20.h),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: _filteredItems.length,
              separatorBuilder: (context, index) => SizedBox(height: 20.h),
              itemBuilder: (context, index) {
                final item = _filteredItems[index];
                return InkWell(
                  onTap: () {
                    widget.onSelected(item);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: widget.itemBuilder?.call(item) ??
                        Text(
                          item.toString(),
                          style: context.theme.fonts.textBaseRegular.copyWith(
                            color: context.theme.colors.textPrimary,
                          ),
                        ),
                  ),
                );
              },
            ),
          ),
          if (widget.actionButtonText != null)
            Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 32.h),
              child: PrimaryButton(
                text: widget.actionButtonText!,
                onPressed: widget.onActionButtonPressed!,
              ),
            ),
        ],
      ),
    );
  }
}
