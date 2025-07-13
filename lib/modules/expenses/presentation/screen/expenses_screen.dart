import 'package:defifundr_mobile/modules/expenses/data/model/expense_model.dart';
import 'package:defifundr_mobile/modules/expenses/presentation/screen/add_expense_screen.dart';
import 'package:defifundr_mobile/modules/expenses/presentation/screen/expense_details_screen.dart';
import 'package:defifundr_mobile/modules/expenses/presentation/screen/time_off_details_screen.dart';
import 'package:defifundr_mobile/modules/expenses/presentation/widgets/empty_state.dart';
import 'package:defifundr_mobile/modules/expenses/presentation/widgets/expense_list_item.dart';
import 'package:flutter/material.dart';

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
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TimeOffDetailsScreen(expense: expense),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ExpenseDetailsScreen(expense: expense),
        ),
      );
    }
  }

  void _addExpense() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddExpenseScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool hasExpenses = _expenses.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Expenses'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.tune, color: Colors.grey[600]),
                    onPressed: () {
                      // Filter functionality
                    },
                  ),
                ),
              ],
            ),
          ),

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
        padding: EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: _addExpense,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Add expense',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
