class Invoice {
  final String id;
  final String title;
  final String client;
  final String amount;
  final String issueDate;
  final InvoiceStatus status;
  final String? transactionId;
  final DateTime? paymentDate;

  const Invoice({
    required this.id,
    required this.title,
    required this.client,
    required this.amount,
    required this.issueDate,
    required this.status,
    this.transactionId,
    this.paymentDate,
  });
}

class InvoiceData {
  String? businessName;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? country;
  String? address;
  String? clientName;
  String? clientEmail;
  String? clientPhone;
  String? clientCountry;
  String? clientAddress;
  String? invoiceTitle;
  List<InvoiceItem> items = [];
  DateTime? issueDate;
  DateTime? dueDate;
  String? paymentMemo;
}

class InvoiceItem {
  final String name;
  final int quantity;
  final double price;

  const InvoiceItem({
    required this.name,
    required this.quantity,
    required this.price,
  });

  double get total => quantity * price;
}

enum InvoiceStatus { pending, paid, overdue }
