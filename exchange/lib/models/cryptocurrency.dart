class Cryptocurrency {
  late final String id, symbol, name, image;
  late final int marketCapRank;
  late final dynamic currentPrice,
      marketCap,
      circulatingSupply,
      totalSupply,
      priceChangePercentage24h;
  late final List<dynamic> price;

  Cryptocurrency(this.id,
      this.symbol,
      this.name,
      this.image,
      this.currentPrice,
      this.marketCap,
      this.marketCapRank,
      this.circulatingSupply,
      this.totalSupply,
      this.priceChangePercentage24h,
      this.price);

  Cryptocurrency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    symbol = json['symbol'];
    name = json['name'];
    image = json['image'];
    currentPrice = json['current_price'];
    marketCap = json['market_cap'];
    marketCapRank = json['market_cap_rank'];
    circulatingSupply = json['circulating_supply'];
    totalSupply = json['total_supply'];
    priceChangePercentage24h = json['price_change_percentage_24h'];

    if (json['sparkline_in_7d'] != null) {
      Map<String, dynamic> sparkline = json['sparkline_in_7d'];
      price = sparkline['price']!;
    }
  }
}