import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/secondary_buttons.dart';
import 'package:defifundr_mobile/modules/expenses/data/model/expense_model.dart';
import 'package:defifundr_mobile/modules/expenses/presentation/widgets/attachment_chip.dart';
import 'package:defifundr_mobile/modules/expenses/presentation/widgets/contract_link.dart';
import 'package:defifundr_mobile/modules/expenses/presentation/widgets/delete_time_off_sheet.dart';
import 'package:defifundr_mobile/modules/expenses/presentation/widgets/detail_row.dart';
import 'package:defifundr_mobile/modules/expenses/presentation/widgets/details_card.dart';
import 'package:defifundr_mobile/modules/expenses/presentation/widgets/status_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:defifundr_mobile/core/extensions/l10n_extension.dart';

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
          textStyle: context.theme.fonts.heading3Bold,
          isBack: true,
          title: context.l10n.timeOffDetails,
          actions: const [],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                  DetailsCard(
                    children: [
                      DetailRow(
                        label: context.l10n.expenseStatus,
                        trailing: StatusChip(status: expense.status),
                      ),
                      DetailRow(label: context.l10n.expenseNameLabel, value: expense.name),
                      DetailRow(label: context.l10n.expenseCategory, value: expense.category),
                      DetailRow(
                        label: context.l10n.expenseDate,
                        value: DateFormat('dd MMM yyyy')
                            .format(expense.expenseDate),
                      ),
                      DetailRow(
                        label: context.l10n.submissionDate,
                        value: DateFormat('dd MMM yyyy')
                            .format(expense.submissionDate),
                      ),
                      DetailRow(
                          label: context.l10n.amount,
                          value: '${expense.amount.toInt()} USDT'),
                      DetailRow(label: context.l10n.expenseDescription, isDescription: true),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            expense.description,
                            style: context.theme.fonts.textMdRegular.copyWith(
                              color: context.theme.colors.textPrimary,
                            ),
                          ),
                        ),
                      ),
                      if (expense.attachment != null)
                        DetailRow(
                          label: context.l10n.attachment,
                          trailing: AttachmentChip(name: expense.attachment!),
                        ),
                      if (expense.status == ExpenseStatus.rejected &&
                          expense.rejectionReason != null) ...[
                        DetailRow(
                            label: context.l10n.reasonForRejection, isDescription: true),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              expense.rejectionReason!,
                              style: context.theme.fonts.textMdRegular.copyWith(
                                color: context.theme.colors.redDefault,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 16),
                  DetailsCard(
                    children: [
                      DetailRow(
                        label: context.l10n.contractAction,
                        trailing: ContractLink(name: expense.contract),
                      ),
                      DetailRow(
                          label: context.l10n.contractType,
                          value: expense.contractType ?? '-'),
                      DetailRow(label: context.l10n.expenseClient, value: expense.client ?? '-'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (expense.status == ExpenseStatus.pending)
            Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 32.h),
              child: SecondaryButton(
                text: context.l10n.deleteTimeOff,
                textColor: context.theme.colors.redDefault,
                borderColor: context.theme.colors.redDefault,
                backgroundColor: Colors.transparent,
                enableShine: false,
                onPressed: () => _showDeleteBottomSheet(context),
              ),
            ),
        ],
      ),
    );
  }

  void _showDeleteBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DeleteTimeOffSheet(expense: expense),
    );
  }
}
