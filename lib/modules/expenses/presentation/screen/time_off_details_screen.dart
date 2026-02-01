import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar.dart';
import 'package:defifundr_mobile/modules/expenses/data/model/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class ExpensesTimeOffDetailsScreen extends StatelessWidget {
  final Expense expense;

  const ExpensesTimeOffDetailsScreen({Key? key, required this.expense})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.screenWidth(), 60),
        child: DeFiRaiseAppBar(
          centerTitle: true,
          textStyle: context.theme.fonts.heading3SemiBold,
          isBack: true,
          title: 'Time off details',
          actions: [],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              if (expense.status == ExpenseStatus.rejected)
                _buildRejectionAlert(context),
              const SizedBox(height: 24),
              _buildTimeOffDetailsSection(context),
              const SizedBox(height: 24),
              _buildDescriptionSection(context),
              if (expense.status == ExpenseStatus.rejected) ...[
                const SizedBox(height: 24),
                _buildRejectionReasonSection(context),
              ],
              const SizedBox(height: 24),
              _buildContractDetailsSection(context),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRejectionAlert(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red[50],
        border: Border.all(color: Colors.red[200]!),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.cancel, color: Colors.red, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Time Off Request Rejected',
                  style: context.theme.fonts.textMdSemiBold.copyWith(
                    fontSize: 13.sp,
                    color: Colors.red[700],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Your time off request has been rejected. Please review the reason below.',
                  style: context.theme.fonts.textMdRegular.copyWith(
                    fontSize: 12.sp,
                    color: Colors.red[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeOffDetailsSection(BuildContext context) {
    return _buildSection(
      context,
      'Time Off Details',
      [
        _buildDetailRow(
          context,
          'Status',
          '',
          statusWidget: _buildStatusChip(context, expense.status),
        ),
        _buildDetailRow(context, 'Name', expense.name),
        _buildDetailRow(context, 'Category', expense.category),
        _buildDetailRow(
            context, 'Start date', _formatDate(expense.expenseDate)),
        _buildDetailRow(
            context, 'Submission date', _formatDate(expense.submissionDate)),
        _buildDetailRow(
            context, 'Duration', '${expense.amount.toInt()} day(s)'),
        _buildDetailRow(
          context,
          'Attachment',
          '',
          attachmentWidget: _buildAttachmentButton(context, expense.attachment),
        ),
      ],
    );
  }

  Widget _buildDescriptionSection(BuildContext context) {
    return _buildSection(
      context,
      'Description',
      [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Text(
            expense.description,
            style: context.theme.fonts.textMdRegular.copyWith(
              fontSize: 13.sp,
              color: context.theme.colors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRejectionReasonSection(BuildContext context) {
    return _buildSection(
      context,
      'Reason for Rejection',
      [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Text(
            expense.rejectionReason ?? 'No reason provided.',
            style: context.theme.fonts.textMdRegular.copyWith(
              fontSize: 13.sp,
              color: Colors.red[700],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContractDetailsSection(BuildContext context) {
    return _buildSection(
      context,
      'Contract Details',
      [
        _buildDetailRow(
          context,
          'Contract',
          '',
          contractWidget: _buildContractButton(context, expense.contract),
        ),
        _buildDetailRow(context, 'Contract Type', expense.contractType ?? ''),
        _buildDetailRow(context, 'Client', expense.client ?? ''),
      ],
    );
  }

  Widget _buildSection(
      BuildContext context, String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.theme.colors.contrastWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: context.theme.colors.textSecondary.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: context.theme.fonts.heading3SemiBold.copyWith(
                fontSize: 18.sp,
                color: context.theme.colors.textPrimary,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(color: context.theme.colors.fillTertiary),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value, {
    Widget? statusWidget,
    Widget? attachmentWidget,
    Widget? contractWidget,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: context.theme.fonts.textMdRegular.copyWith(
                fontSize: 13.sp,
                color: context.theme.colors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (statusWidget != null)
                  statusWidget
                else if (attachmentWidget != null)
                  attachmentWidget
                else if (contractWidget != null)
                  contractWidget
                else
                  Text(
                    value,
                    style: context.theme.fonts.textMdMedium.copyWith(
                      fontSize: 12.sp,
                      color: context.theme.colors.textPrimary,
                    ),
                    textAlign: TextAlign.end,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context, ExpenseStatus status) {
    Color backgroundColor;
    Color textColor;
    String text;

    switch (status) {
      case ExpenseStatus.approved:
        backgroundColor = Colors.green[100]!;
        textColor = Colors.green[700]!;
        text = 'Approved';
        break;
      case ExpenseStatus.pending:
        backgroundColor = Colors.orange[100]!;
        textColor = Colors.orange[700]!;
        text = 'Pending approval';
        break;
      case ExpenseStatus.rejected:
        backgroundColor = Colors.red[100]!;
        textColor = Colors.red[700]!;
        text = 'Rejected';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: context.theme.fonts.textMdMedium.copyWith(
          fontSize: 12.sp,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildAttachmentButton(BuildContext context, String? attachment) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: context.theme.colors.fillTertiary,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.theme.colors.fillTertiary),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.description,
            size: 16,
            color: context.theme.colors.textSecondary,
          ),
          const SizedBox(width: 6),
          Text(
            attachment ?? 'File name.pdf',
            style: context.theme.fonts.textMdRegular.copyWith(
              fontSize: 12.sp,
              color: context.theme.colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContractButton(BuildContext context, String? contract) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            contract ?? 'BlockLayer Validator Inte...',
            style: context.theme.fonts.textMdMedium.copyWith(
              fontSize: 12.sp,
              color: context.theme.colors.textPrimary,
            ),
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        Icon(
          Icons.open_in_new,
          size: 16,
          color: context.theme.colors.textSecondary,
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}
