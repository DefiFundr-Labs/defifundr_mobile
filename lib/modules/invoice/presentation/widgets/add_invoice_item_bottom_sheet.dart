import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:defifundr_mobile/modules/invoice/data/models/invoice_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddInvoiceItemBottomSheet extends StatefulWidget {
  final Function(InvoiceItem)? onAdd;
  final InvoiceItem? item;
  final Function(InvoiceItem)? onSave;
  final VoidCallback? onDelete;

  const AddInvoiceItemBottomSheet({
    Key? key,
    this.onAdd,
    this.item,
    this.onSave,
    this.onDelete,
  }) : super(key: key);

  @override
  State<AddInvoiceItemBottomSheet> createState() =>
      _AddInvoiceItemBottomSheetState();
}

class _AddInvoiceItemBottomSheetState extends State<AddInvoiceItemBottomSheet> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _nameController.text = widget.item!.name;
      _quantityController.text = widget.item!.quantity.toString();
      _priceController.text = widget.item!.price.toString();
    }
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
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 12,
          bottom: 12 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHandle(),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                    widget.item != null
                        ? 'Edit invoice item'
                        : 'Add invoice item',
                    textAlign: TextAlign.center,
                    style: context.theme.fonts.heading3Bold),
              ],
            ),
            const SizedBox(height: 8),
            AppTextField(
              labelText: 'Item name',
              controller: _nameController,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    labelText: 'Quantity',
                    controller: _quantityController,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: AppTextField(
                    labelText: 'Price',
                    controller: _priceController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            if (widget.item != null)
              _buildEditActionButtons()
            else
              PrimaryButton(
                text: 'Add item',
                onPressed: _addItem,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHandle() {
    return Center(
      child: Container(
        width: 48,
        height: 5,
        decoration: BoxDecoration(
          color: context.theme.colors.grayTertiary.withOpacity(0.5),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  void _addItem() {
    if (_nameController.text.isNotEmpty &&
        _quantityController.text.isNotEmpty &&
        _priceController.text.isNotEmpty) {
      final item = InvoiceItem(
        name: _nameController.text,
        quantity: int.tryParse(_quantityController.text) ?? 1,
        price: double.tryParse(_priceController.text) ?? 0.0,
      );
      widget.onAdd?.call(item);
      context.router.maybePop();
    }
  }

  Widget _buildEditActionButtons() {
    return Row(
      children: [
        Expanded(
          child: PrimaryButton(
            text: 'Delete',
            onPressed: () {
              widget.onDelete?.call();
              context.router.maybePop();
            },
            color: Colors.transparent,
            textColor: context.theme.colors.redDefault,
            borderColor: context.theme.colors.redDefault,
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
            int.tryParse(_quantityController.text) ?? widget.item!.quantity,
        price: double.tryParse(_priceController.text) ?? widget.item!.price,
      );
      widget.onSave?.call(updatedItem);
      context.router.maybePop();
    }
  }
}
