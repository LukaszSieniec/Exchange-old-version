import 'cryptocurrency_response.dart';

class Transaction {
  final int? id;
  final String cryptocurrencyId,
      cryptocurrencySymbol,
      cryptocurrencyName,
      type,
      image;
  final double amount;

  Transaction(
      {this.id,
      required this.cryptocurrencyId,
      required this.cryptocurrencySymbol,
      required this.cryptocurrencyName,
      required this.type,
      required this.image,
      required this.amount});

  factory Transaction.fromCryptocurrencyResponse(
          CryptocurrencyResponse cryptocurrencyResponse,
          double amount) =>
      Transaction(
          cryptocurrencyId: cryptocurrencyResponse.id,
          cryptocurrencySymbol: cryptocurrencyResponse.symbol,
          cryptocurrencyName: cryptocurrencyResponse.name,
          type: 'Bought',
          image: cryptocurrencyResponse.image,
          amount: amount);

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
      id: json['id'],
      cryptocurrencyId: json['cryptocurrency_id'],
      cryptocurrencySymbol: json['cryptocurrency_symbol'],
      cryptocurrencyName: json['cryptocurrency_name'],
      type: json['type'],
      image: json['image'],
      amount: json['amount']);

  Map<String, dynamic> toJson() => {
        'cryptocurrency_id': cryptocurrencyId,
        'cryptocurrency_symbol': cryptocurrencySymbol,
        'cryptocurrency_name': cryptocurrencyName,
        'type': type,
        'image': image,
        'amount': amount
      };
}
