import 'package:explore_malaysia/models/property.dart';

class PropertyDetail {
  final String id;
  final String title;
  final String location;
  final double price;
  final String propertyType;
  final int bedrooms;
  final int bathrooms;
  final String imageUrl;
  final double squareFeet;
  final String floorLevel;
  final int yearBuilt;
  final String? leaseStatus;
  final String? leaseTerm;
  final String completionStatus;
  final String furnishing;
  final String description;
  final List<String> amenities;
  final List<String> additionalImages;
  final String agentName;
  final String agentPhone;
  final String agentEmail;
  final String listingType;
  final DateTime listedDate;
  final String propertyFacing;
  final bool hasBalcony;
  final bool hasParking;
  final int parkingSpots;
  final String landTitle;
  final String tenure;
  final bool isFeatured;

  PropertyDetail({
    required this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.propertyType,
    required this.bedrooms,
    required this.bathrooms,
    required this.imageUrl,
    required this.squareFeet,
    required this.floorLevel,
    required this.yearBuilt,
    this.leaseStatus,
    this.leaseTerm,
    required this.completionStatus,
    required this.furnishing,
    required this.description,
    required this.amenities,
    required this.additionalImages,
    required this.agentName,
    required this.agentPhone,
    required this.agentEmail,
    required this.listingType,
    required this.listedDate,
    required this.propertyFacing,
    required this.hasBalcony,
    required this.hasParking,
    required this.parkingSpots,
    required this.landTitle,
    required this.tenure,
    required this.isFeatured,
  });

  factory PropertyDetail.fromJson(Map<String, dynamic> json) {
    return PropertyDetail(
      id: json['id'] as String,
      title: json['title'] as String,
      location: json['location'] as String,
      price: json['price'] as double,
      propertyType: json['propertyType'] as String,
      bedrooms: json['bedrooms'] as int,
      bathrooms: json['bathrooms'] as int,
      imageUrl: json['imageUrl'] as String,
      squareFeet: json['squareFeet'] as double,
      floorLevel: json['floorLevel'] as String,
      yearBuilt: json['yearBuilt'] as int,
      leaseStatus: json['leaseStatus'] as String?,
      leaseTerm: json['leaseTerm'] as String?,
      completionStatus: json['completionStatus'] as String,
      furnishing: json['furnishing'] as String,
      description: json['description'] as String,
      amenities: List<String>.from(json['amenities']),
      additionalImages: List<String>.from(json['additionalImages']),
      agentName: json['agentName'] as String,
      agentPhone: json['agentPhone'] as String,
      agentEmail: json['agentEmail'] as String,
      listingType: json['listingType'] as String,
      listedDate: DateTime.parse(json['listedDate'] as String),
      propertyFacing: json['propertyFacing'] as String,
      hasBalcony: json['hasBalcony'] as bool,
      hasParking: json['hasParking'] as bool,
      parkingSpots: json['parkingSpots'] as int,
      landTitle: json['landTitle'] as String,
      tenure: json['tenure'] as String,
      isFeatured: json['isFeatured'] as bool,
    );
  }

  // Convert PropertyDetail to Property (for list view)
  Property toProperty() {
    return Property(
      id: id,
      title: title,
      location: location,
      price: price,
      propertyType: propertyType,
      bedrooms: bedrooms,
      bathrooms: bathrooms,
      squareFeet: squareFeet,
      listingType: listingType,
      isFeatured: false,
      imageUrl: imageUrl,
      floorLevel: floorLevel,
      furnishing: furnishing,
      completionStatus: completionStatus,
      yearBuilt: yearBuilt,
      leaseStatus: leaseStatus,
      leaseTerm: null,
    );
  }
}
