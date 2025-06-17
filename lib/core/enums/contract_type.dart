enum ContractType {
  fixed('Fixed Rate'),
  hourly('Pay As You Go'),
  milestone('Milestone');

  final String label;
  const ContractType(this.label);
}
