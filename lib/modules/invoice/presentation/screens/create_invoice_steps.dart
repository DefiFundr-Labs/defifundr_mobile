import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:defifundr_mobile/modules/invoice/data/models/app_%20constants.dart';
import 'package:defifundr_mobile/modules/invoice/data/models/invoice_models.dart';
import 'package:defifundr_mobile/modules/invoice/presentation/widgets/add_invoice_item_bottom_sheet.dart';
import 'package:defifundr_mobile/modules/invoice/presentation/widgets/edit_invoice_item_bottom_sheet.dart';
import 'package:defifundr_mobile/modules/invoice/presentation/widgets/invoice_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class YourDetailsStep extends StatefulWidget {
  final InvoiceData invoiceData;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const YourDetailsStep({
    Key? key,
    required this.invoiceData,
    required this.onNext,
    required this.onBack,
  }) : super(key: key);

  @override
  State<YourDetailsStep> createState() => _YourDetailsStepState();
}

class _YourDetailsStepState extends State<YourDetailsStep> {
  bool isRegisteredBusiness = false;

  // Text Controllers
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _taxIdController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();

  @override
  void dispose() {
    _countryController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _taxIdController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _postalCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildBusinessToggle(),
                    SizedBox(height: 24.h),
                    _buildFormFields(),
                  ],
                ),
              ),
            ),
            PrimaryButton(
              text: 'Continue',
              onPressed: widget.onNext,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBusinessToggle() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: context.theme.colors.fillTertiary.withAlpha(4),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'I am registered as a business',
            style: context.theme.fonts.textMdRegular.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          Switch(
            value: isRegisteredBusiness,
            onChanged: (value) {
              setState(() {
                isRegisteredBusiness = value;
              });
            },
            activeColor: context.theme.colors.bgB0,
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

  Widget _buildFormFields() {
    return Column(
      children: [
        if (isRegisteredBusiness) ...[
          AppTextField(
            labelText: 'Business name',
            controller: _businessNameController,
          ),
          SizedBox(height: 16.h),
        ] else ...[
          AppTextField(
            labelText: 'First name',
            hintText: 'Enter your first name',
            controller: _firstNameController,
          ),
          SizedBox(height: 16.h),
          AppTextField(
            labelText: 'Last name',
            hintText: 'Enter your last name',
            controller: _lastNameController,
          ),
          SizedBox(height: 16.h),
        ],
        AppTextField(
          labelText: 'Email address',
          hintText: 'Enter your email address',
          controller: _emailController,
        ),
        SizedBox(height: 16.h),
        _buildPhoneField(),
        SizedBox(height: 16.h),
        if (isRegisteredBusiness) ...[
          AppTextField(
            labelText: 'Tax ID',
            hintText: 'Enter your tax ID',
            controller: _taxIdController,
          ),
          SizedBox(height: 16.h),
        ],
        _buildDropdownField('Country'),
        SizedBox(height: 16.h),
        AppTextField(
          labelText: 'Street',
          hintText: 'Enter your street address',
          controller: _streetController,
        ),
        SizedBox(height: 16.h),
        AppTextField(
          labelText: 'City',
          hintText: 'Enter your city',
          controller: _cityController,
        ),
        SizedBox(height: 16.h),
        AppTextField(
          labelText: 'Postal / zip code',
          hintText: 'Enter your postal/zip code',
          controller: _postalCodeController,
        ),
        SizedBox(height: 24.h),
      ],
    );
  }

  Widget _buildPhoneField() {
    return AppTextField(
      hintText: 'Enter your phone number',
      alwaysShowLabelAndHint: true,
      controller: _phoneController,
      prefixType: PrefixType.customIcon,
      prefixIcon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            Assets.icons.countryFlags.nigeria,
            height: 20.sp,
            width: 20.sp,
          ),
          const SizedBox(width: 8),
          const Text('+234', style: TextStyle(fontWeight: FontWeight.w500)),
          const Icon(Icons.arrow_drop_down, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildDropdownField(String hint) {
    return AppTextField(
      labelText: hint,
      hintText: 'Select $hint',
      controller: _countryController,
      suffixIcon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
    );
  }
}

class ClientDetailsStep extends StatefulWidget {
  final InvoiceData invoiceData;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const ClientDetailsStep({
    Key? key,
    required this.invoiceData,
    required this.onNext,
    required this.onBack,
  }) : super(key: key);

  @override
  State<ClientDetailsStep> createState() => _ClientDetailsStepState();
}

class _ClientDetailsStepState extends State<ClientDetailsStep> {
  bool isNewClient = true;
  bool isRegisteredBusiness = true;

  // Text Controllers
  final TextEditingController _clientNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _savedClientController = TextEditingController();

  @override
  void dispose() {
    _clientNameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _countryController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _postalCodeController.dispose();
    _savedClientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildClientTypeToggle(),
                    SizedBox(height: 24.h),
                    if (isNewClient)
                      _buildNewClientForm()
                    else
                      _buildSavedClientForm(),
                  ],
                ),
              ),
            ),
            PrimaryButton(
              text: 'Continue',
              onPressed: widget.onNext,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClientTypeToggle() {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.colors.fillTertiary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: context.theme.colors.fillTertiary,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isNewClient = true),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: isNewClient ? Colors.white : Colors.grey[100],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                child: Text(
                  'New client',
                  textAlign: TextAlign.center,
                  style: isNewClient
                      ? context.theme.fonts.textMdMedium.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: isNewClient
                              ? context.theme.colors.textPrimary
                              : context.theme.colors.textPrimary)
                      : context.theme.fonts.textMdRegular.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: isNewClient
                              ? context.theme.colors.textPrimary
                              : context.theme.colors.textPrimary),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isNewClient = false),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: !isNewClient ? Colors.white : Colors.grey[100],
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Text(
                  'Saved client',
                  textAlign: TextAlign.center,
                  style: !isNewClient
                      ? context.theme.fonts.textMdMedium.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: isNewClient
                              ? context.theme.colors.textPrimary
                              : context.theme.colors.textPrimary)
                      : context.theme.fonts.textMdRegular.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: isNewClient
                              ? context.theme.colors.textPrimary
                              : context.theme.colors.textPrimary),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewClientForm() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Client is registered as a business',
                style: context.theme.fonts.textMdRegular.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Switch(
                value: isRegisteredBusiness,
                onChanged: (value) {
                  setState(() {
                    isRegisteredBusiness = value;
                  });
                },
                activeColor: Colors.white,
                activeTrackColor: AppConstants.primaryBlue,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _buildClientFormFields(),
      ],
    );
  }

  Widget _buildSavedClientForm() {
    return AppTextField(
      labelText: 'Select client',
      hintText: 'Choose from saved clients',
      controller: _savedClientController,
      suffixIcon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
    );
  }

  Widget _buildClientFormFields() {
    return Column(
      children: [
        if (isRegisteredBusiness) ...[
          AppTextField(
            labelText: 'Client name',
            hintText: 'Enter client company name',
            controller: _clientNameController,
          ),
        ] else ...[
          AppTextField(
            labelText: 'First name',
            hintText: 'Enter client first name',
            controller: _firstNameController,
          ),
          SizedBox(height: 16.h),
          AppTextField(
            labelText: 'Last name',
            hintText: 'Enter client last name',
            controller: _lastNameController,
          ),
        ],
        SizedBox(height: 16.h),
        AppTextField(
          labelText: 'Email address',
          hintText: 'Enter client email address',
          controller: _emailController,
        ),
        SizedBox(height: 16.h),
        _buildPhoneField(),
        SizedBox(height: 16.h),
        _buildDropdownField('Country'),
        SizedBox(height: 16.h),
        AppTextField(
          labelText: 'Street',
          hintText: 'Enter client street address',
          controller: _streetController,
        ),
        SizedBox(height: 16.h),
        AppTextField(
          labelText: 'City',
          hintText: 'Enter client city',
          controller: _cityController,
        ),
        SizedBox(height: 16.h),
        AppTextField(
          labelText: 'Postal / zip code',
          hintText: 'Enter client postal/zip code',
          controller: _postalCodeController,
        ),
      ],
    );
  }

  Widget _buildPhoneField() {
    return AppTextField(
      labelText: 'Phone number',
      hintText: 'Enter client phone number',
      controller: _phoneController,
      prefixIcon: Container(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 24,
              height: 16,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: Colors.green,
              ),
            ),
            const SizedBox(width: 8),
            const Text('+234', style: TextStyle(fontWeight: FontWeight.w500)),
            const Icon(Icons.arrow_drop_down, color: Colors.grey),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownField(String hint) {
    return AppTextField(
      labelText: hint,
      hintText: 'Select $hint',
      controller: _countryController,
      suffixIcon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
    );
  }
}

class InvoiceDetailsStep extends StatefulWidget {
  final InvoiceData invoiceData;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const InvoiceDetailsStep({
    Key? key,
    required this.invoiceData,
    required this.onNext,
    required this.onBack,
  }) : super(key: key);

  @override
  State<InvoiceDetailsStep> createState() => _InvoiceDetailsStepState();
}

class _InvoiceDetailsStepState extends State<InvoiceDetailsStep> {
  List<InvoiceItem> items = [
    const InvoiceItem(
        name: 'User Flow & Wireframe Design', quantity: 100, price: 5.0),
    const InvoiceItem(
        name: 'User Flow & Wireframe Design', quantity: 100, price: 5.0),
  ];
  bool addInclusiveTax = false;

  // Text Controllers
  final TextEditingController _invoiceTitleController = TextEditingController();
  final TextEditingController _networkController = TextEditingController();
  final TextEditingController _assetController = TextEditingController();
  final TextEditingController _issueDateController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();
  final TextEditingController _paymentMemoController = TextEditingController();

  @override
  void dispose() {
    _invoiceTitleController.dispose();
    _issueDateController.dispose();
    _dueDateController.dispose();
    _paymentMemoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInvoiceNumber(),
                    const SizedBox(height: 24),
                    AppTextField(
                      labelText: 'Invoice title',
                      hintText: 'Enter invoice title',
                      controller: _invoiceTitleController,
                    ),
                    SizedBox(height: 24.h),
                    AppTextField(
                      labelText: 'Network',
                      hintText: "Select Network",
                      controller: _networkController,
                    ),
                    SizedBox(height: 16.h),
                    AppTextField(
                      labelText: 'Asset',
                      hintText: "Select Asset",
                      controller: _assetController,
                    ),
                    SizedBox(height: 32.h),
                    _buildInvoiceItemsSection(),
                    SizedBox(height: 24.h),
                    _buildInclusiveTaxToggle(),
                    SizedBox(height: 24.h),
                    _buildDateFields(),
                    SizedBox(height: 24.h),
                    AppTextField(
                      alwaysShowLabelAndHint: true,
                      hintText: 'Payment memo',
                      maxLine: 10,
                      controller: _paymentMemoController,
                    ),
                  ],
                ),
              ),
            ),
            PrimaryButton(
              text: 'Continue',
              onPressed: widget.onNext,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInvoiceNumber() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Opacity(
          opacity: 0.50,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10.sp),
            decoration: ShapeDecoration(
              color: context.theme.colors.bgB0,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  strokeAlign: BorderSide.strokeAlignOutside,
                  color: context.theme.colors.strokeSecondary,
                ),
                borderRadius: BorderRadius.circular(12),
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
                                color: context.theme.colors.textSecondary,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              '#INV-2025-001',
                              style: context.theme.fonts.textSmRegular.copyWith(
                                color: context.theme.colors.textPrimary,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
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
        ),
      ],
    );
  }

  Widget _buildInvoiceItemsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Invoice items',
              style: context.theme.fonts.textBaseMedium.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: _showAddItemBottomSheet,
              style: TextButton.styleFrom(
                backgroundColor: context.theme.colors.textPrimary.withAlpha(60),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Add item',
                style: context.theme.fonts.textMdMedium.copyWith(
                  color: context.theme.colors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        ...items.asMap().entries.map((entry) {
          int index = entry.key;
          InvoiceItem item = entry.value;
          return InvoiceItemCard(
            item: item,
            onEdit: () => _showEditItemBottomSheet(index),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildInclusiveTaxToggle() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: context.theme.colors.fillTertiary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Add inclusive tax',
            style: context.theme.fonts.textMdRegular.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Switch(
            value: addInclusiveTax,
            onChanged: (value) {
              setState(() {
                addInclusiveTax = value;
              });
            },
            activeColor: Colors.white,
            activeTrackColor: AppConstants.primaryBlue,
          ),
        ],
      ),
    );
  }

  Widget _buildDateFields() {
    return Column(
      children: [
        AppTextField(
          labelText: 'Issue date',
          hintText: 'Select issue date',
          controller: _issueDateController,
          suffixType: SuffixType.customIcon,
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: SvgPicture.asset(
              Assets.icons.calendar,
              width: 20.w,
              height: 20.h,
              color: context.theme.colors.textSecondary,
            ),
          ),
        ),
        SizedBox(height: 16.h),
        AppTextField(
          labelText: 'Due date',
          hintText: 'Select due date',
          controller: _dueDateController,
          suffixType: SuffixType.customIcon,
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: SvgPicture.asset(
              Assets.icons.calendar,
              width: 20.w,
              height: 20.h,
              color: context.theme.colors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  void _showAddItemBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddInvoiceItemBottomSheet(
        onAdd: (item) {
          setState(() {
            items.add(item);
          });
        },
      ),
    );
  }

  void _showEditItemBottomSheet(int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => EditInvoiceItemBottomSheet(
        item: items[index],
        onSave: (updatedItem) {
          setState(() {
            items[index] = updatedItem;
          });
        },
        onDelete: () {
          setState(() {
            items.removeAt(index);
          });
        },
      ),
    );
  }
}

class ReviewSignStep extends StatelessWidget {
  final InvoiceData invoiceData;
  final VoidCallback onBack;
  final VoidCallback onComplete;

  const ReviewSignStep({
    Key? key,
    required this.invoiceData,
    required this.onBack,
    required this.onComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildYourDetailsSection(context),
                    const SizedBox(height: 32),
                    _buildClientDetailsSection(context),
                    const SizedBox(height: 32),
                    _buildPaymentInvoiceSection(context),
                  ],
                ),
              ),
            ),
            PrimaryButton(
              text: 'Continue',
              onPressed: onComplete,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildYourDetailsSection(BuildContext context) {
    return _buildSection(
        'Your details',
        [
          _buildDetailRow(context, 'First name', 'Adegboyega'),
          _buildDetailRow(context, 'Last name', 'Oluwagbemiro'),
          _buildDetailRow(context, 'Email', 'adeshinaadegboyega@icloud.com'),
          _buildDetailRow(context, 'Phone no', '+234 (801) 234 5678'),
          _buildDetailRow(context, 'Country', 'Nigeria',
              flag: Assets.icons.countryFlags.nigeria),
          _buildDetailRow(context, 'Address',
              'No 8 James Robertson Shittu/\nOgunlana Drive, Surulere | 142261'),
        ],
        context);
  }

  Widget _buildClientDetailsSection(BuildContext context) {
    return _buildSection(
        'Client details',
        [
          _buildDetailRow(context, 'Name', 'Adegboyega Oluwagbemiro'),
          _buildDetailRow(context, 'Email', 'adeshinaadegboyega@icloud.com'),
          _buildDetailRow(context, 'Phone no', '+234 (801) 234 5678'),
          _buildDetailRow(context, 'Country', 'Nigeria',
              flag: Assets.icons.countryFlags.nigeria),
          _buildDetailRow(context, 'Address',
              'No 8 James Robertson Shittu/\nOgunlana Drive, Surulere | 142261'),
        ],
        context);
  }

  Widget _buildPaymentInvoiceSection(BuildContext context) {
    return _buildSection(
        'Payment & invoice',
        [
          _buildDetailRow(context, 'Invoice no', '#INV-2025-001'),
          _buildDetailRow(
              context, 'Title', 'Neurolytix initial consultation\nsession'),
          _buildNetworkRow('Network', 'Ethereum', context),
          _buildAssetRow('Asset', 'USDT', context),
          _buildDetailRow(context, 'Total amount', '581 USDT',
              hasDropdown: true),
          _buildDetailRow(context, 'Issue date', '15 April 2025'),
          _buildDetailRow(context, 'Due date', '29 April 2025'),
          _buildMemoRow(),
        ],
        context);
  }

  Widget _buildSection(
      String title, List<Widget> children, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.colors.bgB0,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: context.theme.fonts.textMdSemiBold.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor:
                        context.theme.colors.textSecondary.withAlpha(60),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Edit',
                    style: context.theme.fonts.textMdMedium.copyWith(
                      color: context.theme.colors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey[200]),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value,
      {String flag = "", bool hasDropdown = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: context.theme.fonts.textBaseRegular.copyWith(
                fontSize: 13.sp,
                color: context.theme.colors.textSecondary,
              ),
            ),
          ),
          Row(
            children: [
              if (flag.isNotEmpty) ...[
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: SvgPicture.asset(
                    flag,
                    width: 20.w,
                    height: 14.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
              Text(
                value,
                style: context.theme.fonts.textMdMedium.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (hasDropdown)
                Column(
                  children: [
                    SizedBox(width: 6.w),
                    SvgPicture.asset(
                      Assets.icons.caretDown,
                      width: 16.w,
                      height: 16.h,
                      color: context.theme.colors.textSecondary,
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNetworkRow(String label, String value, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100.w,
            child: Text(
              label,
              style: context.theme.fonts.textBaseRegular.copyWith(
                fontSize: 13.sp,
                color: context.theme.colors.textSecondary,
              ),
            ),
          ),
          Row(
            children: [
              Container(
                width: 20,
                height: 20,
                margin: const EdgeInsets.only(right: 8),
                decoration: const BoxDecoration(
                  color: AppConstants.primaryBlue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.currency_bitcoin,
                  color: Colors.white,
                  size: 12,
                ),
              ),
              Text(
                value,
                style: context.theme.fonts.textMdMedium.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAssetRow(String label, String value, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ),
          Row(
            children: [
              Container(
                width: 20,
                height: 20,
                margin: const EdgeInsets.only(right: 8),
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    'T',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
              Text(
                value,
                style: context.theme.fonts.textMdMedium.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMemoRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment memo',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Thank you for your business. Please remit payment according to the terms outlined in this invoice. If you have any questions regarding this invoice or the payment process, do not hesitate to contact us.',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
