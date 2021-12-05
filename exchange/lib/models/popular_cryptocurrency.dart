class PopularCryptocurrency {
  final String id, name, symbol;

  PopularCryptocurrency(
      {required this.id, required this.name, required this.symbol});

  factory PopularCryptocurrency.fromJson(Map<String, dynamic> json) {
    late final Map<String, dynamic> cryptocurrency;
    if (json['item'] != null) cryptocurrency = json['item'];

    return PopularCryptocurrency(
        id: cryptocurrency['id'],
        name: cryptocurrency['name'],
        symbol: cryptocurrency['symbol']);
  }
}
