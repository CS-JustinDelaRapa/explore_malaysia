class PropertyStatistics {
  final int totalProperties;
  final int totalApartments;
  final int totalHouses;
  final double averagePrice;

  PropertyStatistics({
    required this.totalProperties,
    required this.totalApartments,
    required this.totalHouses,
    required this.averagePrice,
  });

  factory PropertyStatistics.fromJson(Map<String, dynamic> json) {
    return PropertyStatistics(
      totalProperties: json['total_properties'] ?? 0,
      totalApartments: json['total_apartments'] ?? 0,
      totalHouses: json['total_houses'] ?? 0,
      averagePrice: (json['average_price'] ?? 0).toDouble(),
    );
  }

  factory PropertyStatistics.initial() {
    return PropertyStatistics(
      totalProperties: 0,
      totalApartments: 0,
      totalHouses: 0,
      averagePrice: 0,
    );
  }
}
