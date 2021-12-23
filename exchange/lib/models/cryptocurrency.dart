class Cryptocurrency {
  final String id, symbol, name;
  final double amount;

  Cryptocurrency(
      {required this.id,
      required this.symbol,
      required this.name,
      required this.amount});

  factory Cryptocurrency.fromJson(Map<String, dynamic> json) => Cryptocurrency(
      id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
      amount: json['amount']);

  Map<String, dynamic> toJson() =>
      {'id': id, 'symbol': symbol, 'name': name, 'amount': amount};
}
