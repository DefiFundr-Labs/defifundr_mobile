import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/core/shared/common_ui/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common_ui/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common_ui/textfield/app_text_field.dart';
import 'package:defifundr_mobile/modules/expenses/data/model/expense_model.dart';
import 'package:defifundr_mobile/modules/expenses/presentation/widgets/empty_state.dart';
import 'package:defifundr_mobile/modules/expenses/presentation/widgets/expense_list_item.dart';
import 'package:defifundr_mobile/modules/invoice/presentation/widgets/filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  _ExpensesScreenState createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Sample data - in real app this would come from a database
  final List<Expense> _expenses = [
    Expense(
      id: '1',
      name: 'Cloud Hosting Subscription',
      category: 'Software & Tools',
      expenseDate: DateTime(2025, 5, 21),
      submissionDate: DateTime(2025, 5, 21),
      amount: 21.0,
      description:
          'Monthly payment for hosting project environments and databases on AWS.',
      status: ExpenseStatus.approved,
      type: ExpenseType.timeOff,
      contract: 'BlockLayer Validator Inte...',
      contractType: 'Fixed Rate',
      client: 'Adegboyega Oluwaghemiro',
      attachment: 'File name.pdf',
    ),
    Expense(
      id: '2',
      name: 'Freelance Design Tool License',
      category: 'Software & Tools',
      expenseDate: DateTime(2025, 5, 18),
      submissionDate: DateTime(2025, 5, 18),
      amount: 42.0,
      description:
          'Monthly subscription for design and creative tools used for client deliverables.',
      status: ExpenseStatus.pending,
      type: ExpenseType.expense,
      contract: 'BlockLayer Validator Inte...',
      contractType: 'Fixed Rate',
      client: 'Adegboyega Oluwaghemiro',
      attachment: 'File name.pdf',
    ),
    Expense(
      id: '3',
      name: 'Business Card Printing',
      category: 'Office Supplies',
      expenseDate: DateTime(2025, 5, 15),
      submissionDate: DateTime(2025, 5, 15),
      amount: 35.0,
      description:
          'Printed 500 professional business cards for networking and client meetings.',
      status: ExpenseStatus.rejected,
      type: ExpenseType.timeOff,
      contract: 'BlockLayer Validator Inte...',
      contractType: 'Fixed Rate',
      client: 'Adegboyega Oluwaghemiro',
      attachment: 'File name.pdf',
      rejectionReason:
          'The receipt is missing key details or does not comply with our expense policy. Please provide complete documentation or revise the expense accordingly.',
    ),
    Expense(
      id: '4',
      name: 'Hotel Booking for Project Meeting',
      category: 'Travel',
      expenseDate: DateTime(2025, 5, 12),
      submissionDate: DateTime(2025, 5, 12),
      amount: 150.0,
      description: 'Hotel accommodation for client meeting in Lagos.',
      status: ExpenseStatus.approved,
      type: ExpenseType.expense,
      contract: 'BlockLayer Validator Inte...',
      contractType: 'Fixed Rate',
      client: 'Adegboyega Oluwaghemiro',
      attachment: 'File name.pdf',
    ),
  ];

  void _navigateToExpenseDetails(Expense expense) {
    if (expense.type == ExpenseType.timeOff) {
      context.router.push(ExpensesTimeOffDetailsRoute(expense: expense));
    } else {
      context.router.push(ExpenseDetailsRoute(expense: expense));
    }
  }

  void _addExpense() {
    context.router.push(const AddExpenseRoute());
  }

  @override
  Widget build(BuildContext context) {
    bool hasExpenses = _expenses.isNotEmpty;

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(context.screenWidth(), 60),
          child: DeFiRaiseAppBar(
            centerTitle: true,
            textStyle: context.theme.fonts.heading3SemiBold,
            isBack: true,
            title: 'Expenses',
            actions: [],
          ),
        ),
        body: Column(
          children: [
            // Search bar
            _buildSearchBar(),
            // Content
            Expanded(
              child: hasExpenses
                  ? ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _expenses.length,
                      itemBuilder: (context, index) {
                        return ExpenseListItem(
                          expense: _expenses[index],
                          onTap: () =>
                              _navigateToExpenseDetails(_expenses[index]),
                        );
                      },
                    )
                  : EmptyState(),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: PrimaryButton(
            text: 'Add expense',
            onPressed: _addExpense,
          ),
        ));
  }

  Widget _buildSearchBar() {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: AppTextField(
              controller: _searchController,
              validate: false,
              alwaysShowLabelAndHint: true,
              hintText: "Search",
              prefixType: PrefixType.customIcon,
              prefixIcon: SvgPicture.asset(
                Assets.icons.magnifyingGlass,
                width: 20,
                height: 20,
                color: context.theme.colors.textSecondary,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: _showFilterBottomSheet,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isLight
                    ? context.theme.colors.bgB0
                    : context.theme.colors.bgB1,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: context.theme.colors.strokeSecondary.withAlpha(20),
                ),
              ),
              child: SvgPicture.asset(
                Assets.icons.filter,
                width: 20,
                height: 20,
                color: context.theme.colors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const FilterBottomSheet(),
    );
  }
}
