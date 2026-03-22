import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/modules/finance/data/model/assets.dart';
import 'package:defifundr_mobile/modules/finance/data/model/network.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/create_contract_flow/widgets/review_card.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/create_contract_flow/widgets/review_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewSignStep extends StatelessWidget {
  final Map<String, dynamic> data;
  final Function(int)? onEdit;
  final VoidCallback onBack;
  final VoidCallback onComplete;

  const ReviewSignStep({
    Key? key,
    required this.data,
    this.onEdit,
    required this.onBack,
    required this.onComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                children: [
                  _buildYourDetailsCard(context),
                  SizedBox(height: 16.h),
                  _buildClientDetailsCard(context),
                  SizedBox(height: 16.h),
                  _buildPaymentInvoiceCard(context),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 16, 20, 32.h),
            child: PrimaryButton(
              text: 'Continue',
              onPressed: onComplete,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYourDetailsCard(BuildContext context) {
    return ReviewCard(
      title: 'Your details',
      onEdit: () => onEdit?.call(0),
      child: Column(
        children: [
          ReviewRow(
              label: 'First name',
              value: data['yourFirstName'] ?? 'Adegboyega'),
          ReviewRow(
              label: 'Last name',
              value: data['yourLastName'] ?? 'Oluwagbemiro'),
          ReviewRow(
              label: 'Email',
              value: data['yourEmail'] ?? 'adeshinaadegboyega@icloud.com'),
          ReviewRow(
              label: 'Phone no',
              value: data['yourPhone'] ?? '+234 (801) 234 5678'),
          ReviewRow(
              label: 'Country',
              value: data['yourCountry'] ?? 'Nigeria',
            // icon: ... Can add flag mapping if required
          ),
          ReviewRow(
            label: 'Address',
            value: data['yourAddress'] ??
                'No 8 James Robertson Shittu/\nOgunlana Drive, Surulere | 142261',
          ),
        ],
      ),
    );
  }

  Widget _buildClientDetailsCard(BuildContext context) {
    return ReviewCard(
      title: 'Client details',
      onEdit: () => onEdit?.call(1),
      child: Column(
        children: [
          ReviewRow(
              label: 'Name',
              value: data['clientName'] ?? 'Adegboyega Oluwagbemiro'),
          ReviewRow(
              label: 'Email',
              value: data['clientEmail'] ?? 'adeshinaadegboyega@icloud.com'),
          ReviewRow(
              label: 'Phone no',
              value: data['clientPhone'] ?? '+234 (801) 234 5678'),
          ReviewRow(
              label: 'Country',
              value: data['clientCountry'] ?? 'Nigeria',
          ),
          ReviewRow(
            label: 'Address',
            value: data['clientAddress'] ??
                'No 8 James Robertson Shittu/\nOgunlana Drive, Surulere | 142261',
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentInvoiceCard(BuildContext context) {
    final currentNetwork = Network.supportedNetworks.firstWhere(
      (n) => n.name == (data['network'] ?? 'Ethereum'),
      orElse: () => Network.supportedNetworks.first,
    );
    final currentAsset = NetworkAsset.supportedAssets.firstWhere(
      (a) => a.name == (data['asset'] ?? 'USDT'),
      orElse: () => NetworkAsset.supportedAssets.first,
    );

    return ReviewCard(
      title: 'Payment & invoice',
      onEdit: () => onEdit?.call(2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ReviewRow(label: 'Invoice no', value: '#INV-2025-001'),
          ReviewRow(
              label: 'Title',
              value: data['invoiceTitle'] ??
                  'Neurolytix Initial consultation\nsession'),
          ReviewRow(
            label: 'Network',
            value: data['network'] ?? 'Ethereum',
            icon: currentNetwork.iconPath,
          ),
          ReviewRow(
            label: 'Asset',
            value: data['asset'] ?? 'USDT',
            icon: currentAsset.iconPath,
          ),
          const ReviewRow(label: 'Total amount', value: '581 USDT'),
          ReviewRow(
              label: 'Issue date', value: data['issueDate'] ?? '15 April 2025'),
          ReviewRow(
              label: 'Due date', value: data['dueDate'] ?? '29 April 2025'),
          SizedBox(height: 8.h),
          Text(
            'Payment memo',
            style: context.theme.fonts.textMdRegular.copyWith(
              color: context.theme.colors.textSecondary,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            data['paymentMemo']?.isNotEmpty == true
                ? data['paymentMemo']
                : 'Thank you for your business. Please remit payment according to the terms outlined in this invoice. If you have any questions regarding this invoice or the payment process, do not hesitate to contact us.',
            style: context.theme.fonts.textMdMedium.copyWith(
              height: 1.5,
              fontSize: 13.sp,
              color: context.theme.colors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
