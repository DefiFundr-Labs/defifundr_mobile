class Contract {
  final String id;
  final String title;
  final String type;
  final String paymentAmount;
  final String paymentFrequency;
  final bool isActive;

  Contract({
    required this.id,
    required this.title,
    required this.type,
    required this.paymentAmount,
    required this.paymentFrequency,
    required this.isActive,
  });
}
