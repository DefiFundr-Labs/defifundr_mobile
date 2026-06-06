import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:defifundr_mobile/modules/finance/data/model/assets.dart';
import 'package:defifundr_mobile/modules/finance/data/model/network.dart';
import 'package:defifundr_mobile/modules/invoice/data/models/app_%20constants.dart';
import 'package:defifundr_mobile/modules/invoice/data/models/invoice_models.dart';
import 'package:defifundr_mobile/modules/invoice/presentation/widgets/add_invoice_item_bottom_sheet.dart';
import 'package:defifundr_mobile/modules/invoice/presentation/widgets/invoice_item_card.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/create_contract_flow/widgets/selection_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class InvoiceDetailsStep extends StatelessWidget {
  final List<InvoiceItem> items;
  final ValueChanged<InvoiceItem> onItemAdded;
  final Function(int, InvoiceItem) onItemEdited;
  final ValueChanged<int> onItemDeleted;
  final bool addInclusiveTax;
  final ValueChanged<bool> onTaxToggled;
  final TextEditingController invoiceTitleController;
  final Network? selectedNetwork;
  final NetworkAsset? selectedAsset;
  final ValueChanged<Network?> onNetworkChanged;
  final ValueChanged<NetworkAsset?> onAssetChanged;
  final TextEditingController issueDateController;
  final TextEditingController dueDateController;
  final TextEditingController paymentMemoController;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const InvoiceDetailsStep({
    Key? key,
    required this.items,
    required this.onItemAdded,
    required this.onItemEdited,
    required this.onItemDeleted,
    required this.addInclusiveTax,
    required this.onTaxToggled,
    required this.invoiceTitleController,
    required this.selectedNetwork,
    required this.selectedAsset,
    required this.onNetworkChanged,
    required this.onAssetChanged,
    required this.issueDateController,
    required this.dueDateController,
    required this.paymentMemoController,
    required this.onNext,
    required this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInvoiceNumber(context),
                    SizedBox(height: 20.h),
                    AppTextField(
                      labelText: 'Invoice title',
                      hintText: 'Enter invoice title',
                      controller: invoiceTitleController,
                    ),
                    SizedBox(height: 20.h),
                    AppTextField(
                      controller: TextEditingController(
                          text: selectedNetwork?.name ?? ''),
                      labelText: 'Network',
                      hintText: 'Select network',
                      suffixType: SuffixType.defaultt,
                      readOnly: true,
                      onTap: () => _showNetworkPicker(context),
                      prefixType: selectedNetwork != null
                          ? PrefixType.customWidget
                          : PrefixType.none,
                      prefixWidget: selectedNetwork != null
                          ? Padding(
                              padding: const EdgeInsets.all(12),
                              child: Image.asset(selectedNetwork!.iconPath,
                                  width: 24, height: 24),
                            )
                          : null,
                    ),
                    SizedBox(height: 20.h),
                    AppTextField(
                      controller: TextEditingController(
                          text: selectedAsset?.name ?? ''),
                      labelText: 'Asset',
                      hintText: 'Select asset',
                      suffixType: SuffixType.defaultt,
                      readOnly: true,
                      onTap: () => _showAssetPicker(context),
                      prefixType: selectedAsset != null
                          ? PrefixType.customWidget
                          : PrefixType.none,
                      prefixWidget: selectedAsset != null
                          ? Padding(
                              padding: const EdgeInsets.all(12),
                              child: Image.asset(selectedAsset!.iconPath,
                                  width: 24, height: 24),
                            )
                          : null,
                    ),
                    SizedBox(height: 20.h),
                    _buildInvoiceItemsSection(context),
                    SizedBox(height: 20.h),
                    _buildInclusiveTaxToggle(context),
                    SizedBox(height: 20.h),
                    _buildDateFields(context),
                    SizedBox(height: 20.h),
                    AppTextField(
                      alwaysShowLabelAndHint: true,
                      hintText: 'Payment memo',
                      maxLine: 7,
                      controller: paymentMemoController,
                    ),
                  ],
                ),
              ),
            ),
            PrimaryButton(
              text: 'Continue',
              onPressed: onNext,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInvoiceNumber(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 10.sp),
          decoration: ShapeDecoration(
            color: context.theme.colors.bgB1,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                strokeAlign: BorderSide.strokeAlignOutside,
                color: context.theme.colors.strokeSecondary,
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Invoice number',
                            style: context.theme.fonts.textSmRegular.copyWith(
                                color: context.theme.colors.textSecondary),
                          ),
                          Text(
                            '#INV-2025-001',
                            style: context.theme.fonts.textMdMedium.copyWith(
                              color: context.theme.colors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInvoiceItemsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Invoice items', style: context.theme.fonts.textBaseMedium),
            GestureDetector(
              onTap: () => _showAddItemBottomSheet(context),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: context.theme.colors.fillTertiary,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Add item',
                  style: context.theme.fonts.textSmMedium,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        if (items.isEmpty)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: context.theme.colors.bgB1,
              border: Border.all(
                color: context.theme.colors.strokeSecondary,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Icon(
                  Iconsax.info_circle,
                  size: 20.sp,
                  color: context.theme.colors.textSecondary,
                ),
                SizedBox(width: 8.w),
                Text(
                  'You currently have no invoice item added.',
                  style: context.theme.fonts.textMdRegular.copyWith(
                    color: context.theme.colors.textSecondary,
                  ),
                ),
              ],
            ),
          )
        else
          ...items.asMap().entries.map((entry) {
            int index = entry.key;
            InvoiceItem item = entry.value;
            return InvoiceItemCard(
              item: item,
              onEdit: () => _showEditItemBottomSheet(context, index),
            );
          }).toList(),
      ],
    );
  }

  Widget _buildInclusiveTaxToggle(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: context.theme.colors.fillTertiary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Add inclusive tax', style: context.theme.fonts.textMdRegular),
          Switch(
            value: addInclusiveTax,
            onChanged: onTaxToggled,
            activeThumbColor: context.theme.colors.bgB0,
            trackOutlineColor: WidgetStateProperty.all(
              context.theme.colors.strokeSecondary.withAlpha(20),
            ),
            inactiveThumbColor: context.theme.colors.textSecondary,
            activeTrackColor: context.theme.colors.brandDefault,
          ),
        ],
      ),
    );
  }

  Widget _buildDateFields(BuildContext context) {
    return Column(
      children: [
        AppTextField(
          labelText: 'Issue date',
          hintText: 'Select issue date',
          controller: issueDateController,
          suffixType: SuffixType.customIcon,
          readOnly: true,
          onTap: () => _selectDate(context, issueDateController),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: SvgPicture.asset(
              Assets.icons.calendar,
              width: 20.w,
              height: 20.h,
              colorFilter: ColorFilter.mode(
                context.theme.colors.textSecondary,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        SizedBox(height: 16.h),
        AppTextField(
          labelText: 'Due date',
          hintText: 'Select due date',
          controller: dueDateController,
          suffixType: SuffixType.customIcon,
          readOnly: true,
          onTap: () => _selectDate(context, dueDateController),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: SvgPicture.asset(
              Assets.icons.calendar,
              width: 20.w,
              height: 20.h,
              colorFilter: ColorFilter.mode(
                context.theme.colors.textSecondary,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showAddItemBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => AddInvoiceItemBottomSheet(
        onAdd: onItemAdded,
      ),
    );
  }

  void _showEditItemBottomSheet(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => AddInvoiceItemBottomSheet(
        item: items[index],
        onSave: (updatedItem) => onItemEdited(index, updatedItem),
        onDelete: () => onItemDeleted(index),
      ),
    );
  }

  void _showNetworkPicker(BuildContext context) {
    _showPickerBottomSheet(
      context: context,
      title: 'Select network',
      items: Network.supportedNetworks,
      onSelected: (val) => onNetworkChanged(val as Network),
      itemBuilder: (item) => Row(
        children: [
          Image.asset((item as Network).iconPath, width: 32, height: 32),
          const SizedBox(width: 12),
          Text(item.name, style: context.theme.fonts.textMdMedium),
        ],
      ),
    );
  }

  void _showAssetPicker(BuildContext context) {
    _showPickerBottomSheet(
      context: context,
      title: 'Select assets',
      items: NetworkAsset.supportedAssets,
      onSelected: (val) => onAssetChanged(val as NetworkAsset),
      itemBuilder: (item) => Row(
        children: [
          Image.asset((item as NetworkAsset).iconPath, width: 32, height: 32),
          const SizedBox(width: 12),
          Text(item.name, style: context.theme.fonts.textMdMedium),
          const Spacer(),
          Text(item.balance, style: context.theme.fonts.textMdRegular),
        ],
      ),
    );
  }

  void _showPickerBottomSheet({
    required BuildContext context,
    required String title,
    required List<dynamic> items,
    required ValueChanged<dynamic> onSelected,
    Widget Function(dynamic)? itemBuilder,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SelectionBottomSheet(
        title: title,
        items: items,
        onSelected: (val) {
          onSelected(val);
          context.router.maybePop();
        },
        itemBuilder: itemBuilder,
      ),
    );
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      controller.text = DateFormat('dd MMM yyyy').format(picked);
    }
  }
}
