class PopularCryptocurrency {
  late final dynamic id, name, symbol;

  PopularCryptocurrency(this.id, this.name, this.symbol);

  PopularCryptocurrency.fromJson(Map<String, dynamic> json) {
    if (json['item'] != null) {
      Map<String, dynamic> cryptocurrency = json['item'];

      id = cryptocurrency['id'];
      name = cryptocurrency['name'];
      symbol = cryptocurrency['symbol'];
    }
  }
}
