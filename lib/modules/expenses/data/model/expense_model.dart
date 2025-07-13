enum ExpenseStatus { approved, pending, rejected }
enum ExpenseType { expense, timeOff }

class Expense {
  final String id;
  final String name;
  final String category;
  final DateTime expenseDate;
  final DateTime submissionDate;
  final double amount;
  final String description;
  final ExpenseStatus status;
  final ExpenseType type;
  final String? contract;
  final String? contractType;
  final String? client;
  final String? attachment;
  final String? rejectionReason;

  Expense({
    required this.id,
    required this.name,
    required this.category,
    required this.expenseDate,
    required this.submissionDate,
    required this.amount,
    required this.description,
    required this.status,
    required this.type,
    this.contract,
    this.contractType,
    this.client,
    this.attachment,
    this.rejectionReason,
  });
}