class Sparkline {
  final List<dynamic> price;

  Sparkline({required this.price});

  factory Sparkline.fromJson(Map<String, dynamic> json) {
    return Sparkline(price: json['price']);
  }
}
