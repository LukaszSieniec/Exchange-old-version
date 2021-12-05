import 'package:exchange/models/sparkline.dart';

class Cryptocurrency {
  final String id, symbol, name, image;
  final int marketCapRank;
  final dynamic currentPrice,
      marketCap,
      circulatingSupply,
      totalSupply,
      priceChangePercentage24h;
  final Sparkline sparkline;

  Cryptocurrency(
      {required this.id,
      required this.symbol,
      required this.name,
      required this.image,
      required this.currentPrice,
      required this.marketCap,
      required this.marketCapRank,
      required this.circulatingSupply,
      required this.totalSupply,
      required this.priceChangePercentage24h,
      required this.sparkline});

  factory Cryptocurrency.fromJson(Map<String, dynamic> json) {
    return Cryptocurrency(
        id: json['id'],
        symbol: json['symbol'],
        name: json['name'],
        image: json['image'],
        currentPrice: json['current_price'],
        marketCap: json['market_cap'],
        marketCapRank: json['market_cap_rank'],
        circulatingSupply: json['circulating_supply'],
        totalSupply: json['total_supply'],
        priceChangePercentage24h: json['price_change_percentage_24h'],
        sparkline: Sparkline.fromJson(json['sparkline_in_7d']));
  }
}
