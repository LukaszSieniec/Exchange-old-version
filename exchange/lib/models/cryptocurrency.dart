class Cryptocurrency {
  late final String id, symbol, name, image;
  late final int currentPrice,
      marketCap,
      marketCapRank,
      circulatingSupply,
      totalSupply;
  late final double priceChangePercentage24h;

  Cryptocurrency(
      this.id,
      this.symbol,
      this.name,
      this.image,
      this.currentPrice,
      this.marketCap,
      this.marketCapRank,
      this.circulatingSupply,
      this.totalSupply,
      this.priceChangePercentage24h);

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
  }
}
