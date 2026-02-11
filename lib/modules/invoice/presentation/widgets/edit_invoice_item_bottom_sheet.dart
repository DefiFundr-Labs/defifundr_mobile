import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:defifundr_mobile/modules/invoice/data/models/invoice_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditInvoiceItemBottomSheet extends StatefulWidget {
  final InvoiceItem item;
  final Function(InvoiceItem) onSave;
  final VoidCallback onDelete;

  const EditInvoiceItemBottomSheet({
    Key? key,
    required this.item,
    required this.onSave,
    required this.onDelete,
  }) : super(key: key);

  @override
  State<EditInvoiceItemBottomSheet> createState() =>
      _EditInvoiceItemBottomSheetState();
}

class _EditInvoiceItemBottomSheetState
    extends State<EditInvoiceItemBottomSheet> {
  late TextEditingController _nameController;
  late TextEditingController _quantityController;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item.name);
    _quantityController =
        TextEditingController(text: widget.item.quantity.toString());
    _priceController =
        TextEditingController(text: widget.item.price.toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: 24 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHandle(),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Edit invoice item',
                  textAlign: TextAlign.center,
                  style: context.theme.fonts.textMdSemiBold.copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            AppTextField(
              labelText: 'Item name',
              hintText: 'Enter item name',
              controller: _nameController,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextField(
                        labelText: 'Quantity',
                        hintText: 'Enter quantity',
                        controller: _quantityController,
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextField(
                        labelText: 'Price',
                        hintText: 'Enter price',
                        controller: _priceController,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHandle() {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {
              widget.onDelete();
              context.router.maybePop();
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side:
                  BorderSide(color: context.theme.colors.redDefault, width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
              ),
            ),
            child: Text(
              'Delete',
              style: context.theme.fonts.textMdMedium.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: context.theme.colors.redDefault,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 1,
          child: PrimaryButton(
            text: 'Save changes',
            onPressed: _saveChanges,
          ),
        ),
      ],
    );
  }

  void _saveChanges() {
    if (_nameController.text.isNotEmpty &&
        _quantityController.text.isNotEmpty &&
        _priceController.text.isNotEmpty) {
      final updatedItem = InvoiceItem(
        name: _nameController.text,
        quantity:
            int.tryParse(_quantityController.text) ?? widget.item.quantity,
        price: double.tryParse(_priceController.text) ?? widget.item.price,
      );
      widget.onSave(updatedItem);
      context.router.maybePop();
    }
  }
}
