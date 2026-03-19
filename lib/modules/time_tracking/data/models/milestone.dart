class Milestone {
  final String id;
  final String name;
  final String description;
  final String amount;
  final String dueDate;

  const Milestone({
    required this.id,
    required this.name,
    required this.description,
    required this.amount,
    required this.dueDate,
  });

  Milestone copyWith({
    String? id,
    String? name,
    String? description,
    String? amount,
    String? dueDate,
  }) {
    return Milestone(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      dueDate: dueDate ?? this.dueDate,
    );
  }
}
