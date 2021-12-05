class MarketChartData {
  final List<dynamic> prices;

  MarketChartData({required this.prices});

  factory MarketChartData.fromJson(Map<String, dynamic> json) {
    return MarketChartData(prices: json['prices']);
  }
}
