class Transaction {
  final String id, name, type;
  final double amount;

  Transaction(
      {required this.id,
      required this.name,
      required this.type,
      required this.amount});
}
