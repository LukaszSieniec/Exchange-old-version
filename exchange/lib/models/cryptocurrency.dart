import 'package:exchange/utils/extensions.dart';

import 'cryptocurrency_response.dart';

class Cryptocurrency {
  final String id, symbol, name, image;
  final double amount;

  Cryptocurrency(
      {required this.id,
      required this.symbol,
      required this.name,
      required this.amount,
      required this.image});

  factory Cryptocurrency.fromJson(Map<String, dynamic> json) => Cryptocurrency(
      id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
      amount: json['amount'],
      image: json['image']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'symbol': symbol,
        'name': name,
        'amount': amount,
        'image': image
      };

  factory Cryptocurrency.fromCryptocurrencyResponse(
          CryptocurrencyResponse cryptocurrencyResponse, double amount) =>
      Cryptocurrency(
          id: cryptocurrencyResponse.id,
          symbol: cryptocurrencyResponse.symbol,
          name: cryptocurrencyResponse.name,
          amount: amount,
          image: cryptocurrencyResponse.image);

  Cryptocurrency copyWith(
      {String? id,
      String? symbol,
      String? name,
      double? amount,
      String? image}) {
    return Cryptocurrency(
        id: id ?? this.id,
        symbol: symbol ?? this.symbol,
        name: name ?? this.name,
        amount: amount?.setAmountCryptocurrencyPrecision() ?? this.amount,
        image: image ?? this.image);
  }
}
