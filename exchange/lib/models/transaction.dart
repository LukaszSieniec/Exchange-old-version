class Transaction {
  final String id, cryptocurrencySymbol, cryptocurrencyName, type;
  final double amount;

  Transaction(
      {required this.id,
      required this.cryptocurrencySymbol,
      required this.cryptocurrencyName,
      required this.type,
      required this.amount});

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
      id: json['id'],
      cryptocurrencySymbol: json['cryptocurrency_symbol'],
      cryptocurrencyName: json['cryptocurrency_name'],
      type: json['type'],
      amount: json['amount']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'cryptocurrency_symbol': cryptocurrencySymbol,
        'cryptocurrency_name': cryptocurrencyName,
        'type': type,
        'amount': amount
      };
}
