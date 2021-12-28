import 'cryptocurrency_response.dart';

class Transaction {
  final int? id;
  final String cryptocurrencyId,
      cryptocurrencySymbol,
      cryptocurrencyName,
      type,
      date,
      image;
  final double amount, cryptocurrencyPrice;

  Transaction(
      {this.id,
      required this.cryptocurrencyId,
      required this.cryptocurrencySymbol,
      required this.cryptocurrencyName,
      required this.type,
      required this.date,
      required this.image,
      required this.amount,
      required this.cryptocurrencyPrice});

  factory Transaction.fromCryptocurrencyResponse(
          CryptocurrencyResponse cryptocurrencyResponse, double amount) =>
      Transaction(
          cryptocurrencyId: cryptocurrencyResponse.id,
          cryptocurrencySymbol: cryptocurrencyResponse.symbol,
          cryptocurrencyName: cryptocurrencyResponse.name,
          type: 'Bought',
          date: DateTime.now().toIso8601String(),
          image: cryptocurrencyResponse.image,
          amount: amount,
          cryptocurrencyPrice: cryptocurrencyResponse.currentPrice);

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
      id: json['id'],
      cryptocurrencyId: json['cryptocurrency_id'],
      cryptocurrencySymbol: json['cryptocurrency_symbol'],
      cryptocurrencyName: json['cryptocurrency_name'],
      type: json['type'],
      date: json['date'],
      image: json['image'],
      amount: json['amount'],
      cryptocurrencyPrice: json['cryptocurrency_price']);

  Map<String, dynamic> toJson() => {
        'cryptocurrency_id': cryptocurrencyId,
        'cryptocurrency_symbol': cryptocurrencySymbol,
        'cryptocurrency_name': cryptocurrencyName,
        'type': type,
        'date': date,
        'image': image,
        'amount': amount,
        'cryptocurrency_price': cryptocurrencyPrice
      };
}
