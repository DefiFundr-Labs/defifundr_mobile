import 'package:defifundr_mobile/modules/expenses/data/model/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseDetailsScreen extends StatelessWidget {
  final Expense expense;

  const ExpenseDetailsScreen({Key? key, required this.expense}) : super(key: key);

  void _deleteExpense(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Expense'),
          content: Text('Are you sure you want to delete this expense?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Go back to expenses list
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Expense deleted successfully')),
                );
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Expense details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Column(
            children: [
              _buildDetailRow('Status', _buildStatusChip(expense.status)),
              _buildDetailRow('Name', Text(expense.name, style: TextStyle(fontWeight: FontWeight.w500))),
              _buildDetailRow('Category', Text(expense.category, style: TextStyle(fontWeight: FontWeight.w500))),
              _buildDetailRow('Expense date', Text(_formatDate(expense.expenseDate), style: TextStyle(fontWeight: FontWeight.w500))),
              _buildDetailRow('Submission date', Text(_formatDate(expense.submissionDate), style: TextStyle(fontWeight: FontWeight.w500))),
              _buildDetailRow('Amount', Text('${expense.amount.toInt()} USDT', style: TextStyle(fontWeight: FontWeight.w500))),
              _buildDetailRow('Description', null, isDescription: true),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  expense.description,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              _buildDetailRow('Attachment', _buildAttachmentButton(expense.attachment)),
              SizedBox(height: 24),
              _buildDetailRow('Contract', _buildContractButton(expense.contract)),
              _buildDetailRow('Contract Type', Text(expense.contractType ?? '', style: TextStyle(fontWeight: FontWeight.w500))),
              _buildDetailRow('Client', Text(expense.client ?? '', style: TextStyle(fontWeight: FontWeight.w500))),
            ],
          ),
        ),
      ),
      bottomNavigationBar: expense.status == ExpenseStatus.pending
          ? Container(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: () => _deleteExpense(context),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Delete expense',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildDetailRow(String label, Widget? value, {bool isDescription = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ),
          if (!isDescription) Expanded(child: value ?? SizedBox()),
        ],
      ),
    );
  }

  Widget _buildStatusChip(ExpenseStatus status) {
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
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildAttachmentButton(String? attachment) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.description, size: 16, color: Colors.grey[600]),
          SizedBox(width: 6),
          Text(
            attachment ?? 'File name.pdf',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContractButton(String? contract) {
    return Row(
      children: [
        Text(
          contract ?? 'BlockLayer Validator Inte...',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        SizedBox(width: 8),
        Icon(Icons.open_in_new, size: 16, color: Colors.grey[600]),
      ],
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}