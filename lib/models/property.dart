class Property {
  final String id;
  final String title;
  final String location;
  final double price;
  final String propertyType;
  final int bedrooms;
  final int bathrooms;
  final double squareFeet;
  final String imageUrl;
  final String listingType; // For Sale/For Rent
  final bool isFeatured;
  
  // Search filter fields
  final String floorLevel;
  final String furnishing;
  final String completionStatus;
  final int yearBuilt;
  final String? leaseStatus;
  final String? leaseTerm;

  Property({
    required this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.propertyType,
    required this.bedrooms,
    required this.bathrooms,
    required this.squareFeet,
    required this.imageUrl,
    required this.listingType,
    required this.isFeatured,
    required this.floorLevel,
    required this.furnishing,
    required this.completionStatus,
    required this.yearBuilt,
    this.leaseStatus,
    this.leaseTerm,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['id'] as String,
      title: json['title'] as String,
      location: json['location'] as String,
      price: json['price'] as double,
      propertyType: json['propertyType'] as String,
      bedrooms: json['bedrooms'] as int,
      bathrooms: json['bathrooms'] as int,
      squareFeet: json['squareFeet'] as double,
      imageUrl: json['imageUrl'] as String,
      listingType: json['listingType'] as String,
      isFeatured: json['isFeatured'] as bool,
      floorLevel: json['floorLevel'] as String,
      furnishing: json['furnishing'] as String,
      completionStatus: json['completionStatus'] as String,
      yearBuilt: json['yearBuilt'] as int,
      leaseStatus: json['leaseStatus'] as String?,
      leaseTerm: json['leaseTerm'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'location': location,
      'price': price,
      'propertyType': propertyType,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'squareFeet': squareFeet,
      'imageUrl': imageUrl,
      'listingType': listingType,
      'isFeatured': isFeatured,
      'floorLevel': floorLevel,
      'furnishing': furnishing,
      'completionStatus': completionStatus,
      'yearBuilt': yearBuilt,
      'leaseStatus': leaseStatus,
      'leaseTerm': leaseTerm,
    };
  }
}
