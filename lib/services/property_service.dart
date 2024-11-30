import 'package:explore_malaysia/models/property.dart';
import 'package:explore_malaysia/models/property_detail.dart';

class PropertyService {
  static final PropertyService _instance = PropertyService._internal();

  factory PropertyService() {
    return _instance;
  }

  PropertyService._internal();

  Future<List<Property>> getFeaturedProperties() async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 800));

    return [
      Property(
        id: 'prop1',
        title: 'Taman Manikar Bungalow',
        location: 'Likas, Kota Kinabalu',
        price: 1580000.0,
        propertyType: 'Bungalow',
        bedrooms: 5,
        bathrooms: 4,
        imageUrl: 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2340&q=80',
        squareFeet: 3200.0,
        listingType: 'For Sale',
        completionStatus: 'Ready',
        isFeatured: true,
        floorLevel: 'Ground Floor',
        furnishing: 'Partially Furnished',
        yearBuilt: 2022,
        leaseStatus: 'Active',
        leaseTerm: '99 years',
      ),
      Property(
        id: 'prop2',
        title: 'Jesselton Office Tower',
        location: 'KK Times Square, Kota Kinabalu',
        price: 3800000.0,
        propertyType: 'Office',
        bedrooms: 0,
        bathrooms: 2,
        imageUrl: 'https://images.unsplash.com/photo-1497366216548-37526070297c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2301&q=80',
        squareFeet: 2500.0,
        listingType: 'For Sale',
        completionStatus: 'Ready',
        isFeatured: true,
        floorLevel: '15th Floor',
        furnishing: 'Fully Furnished',
        yearBuilt: 2020,
        leaseStatus: 'Active',
        leaseTerm: '99 years',
      ),
      Property(
        id: 'prop3',
        title: 'Imago Shopping Mall Shop Lot',
        location: 'Imago Mall, Kota Kinabalu',
        price: 12000.0,
        propertyType: 'Retail',
        bedrooms: 0,
        bathrooms: 1,
        imageUrl: 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2340&q=80',
        squareFeet: 1200.0,
        listingType: 'For Rent',
        completionStatus: 'Ready',
        isFeatured: false,
        floorLevel: 'Ground Floor',
        furnishing: 'Bare',
        yearBuilt: 2019,
        leaseStatus: 'Active',
        leaseTerm: '99 years',
      ),
      Property(
        id: 'prop4',
        title: 'Marina Court Luxury Condo',
        location: 'Marina Court, Kota Kinabalu',
        price: 850000.0,
        propertyType: 'Condominium',
        bedrooms: 3,
        bathrooms: 2,
        imageUrl: 'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2340&q=80',
        squareFeet: 1250.0,
        listingType: 'For Sale',
        completionStatus: 'Ready',
        isFeatured: true,
        floorLevel: '12th Floor',
        furnishing: 'Fully Furnished',
        yearBuilt: 2018,
        leaseStatus: 'Active',
        leaseTerm: '99 years',
      ),
      Property(
        id: 'prop5',
        title: 'Riverson SOHO Suite',
        location: 'Sembulan, Kota Kinabalu',
        price: 2800.0,
        propertyType: 'SOHO',
        bedrooms: 1,
        bathrooms: 1,
        imageUrl: 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2340&q=80',
        squareFeet: 750.0,
        listingType: 'For Rent',
        completionStatus: 'Ready',
        isFeatured: false,
        floorLevel: '8th Floor',
        furnishing: 'Fully Furnished',
        yearBuilt: 2021,
        leaseStatus: 'Active',
        leaseTerm: '99 years',
      ),
    ];
  }

  Future<PropertyDetail> getPropertyDetails(String propertyId) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 800));

    final Map<String, dynamic> mockPropertyDetails;

    switch (propertyId) {
      case 'prop1':
        mockPropertyDetails = {
          'id': propertyId,
          'title': 'Taman Manikar Bungalow',
          'location': 'Likas, Kota Kinabalu',
          'price': 1580000.0,
          'propertyType': 'Bungalow',
          'bedrooms': 5,
          'bathrooms': 4,
          'imageUrl': 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2340&q=80',
          'squareFeet': 3200.0,
          'floorLevel': 'Ground Floor',
          'yearBuilt': 2022,
          'completionStatus': 'Ready',
          'furnishing': 'Partially Furnished',
          'description': '''
Introducing this stunning new bungalow in the prestigious Taman Manikar area of Likas. 
This modern 5-bedroom residence offers luxurious living with high-end finishes throughout.

Features:
- Spacious living areas with high ceilings
- Modern kitchen with built-in appliances
- Master bedroom with walk-in wardrobe
- Private garden with landscaping
- Covered parking for 2 cars
''',
          'listingType': 'For Sale',
          'propertyFacing': 'North',
          'additionalImages': [
            'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&q=80&w=2340&h=1560&ixlib=rb-4.0.3',
            'https://images.unsplash.com/photo-1613977257363-707ba9348227?auto=format&fit=crop&q=80&w=2340&h=1560&ixlib=rb-4.0.3',
            'https://images.unsplash.com/photo-1613977257592-4871e5fcd7c4?auto=format&fit=crop&q=80&w=2340&h=1560&ixlib=rb-4.0.3',
          ],
          'amenities': [
            'Swimming Pool',
            'Gymnasium',
            'Security',
            'Covered Parking',
            'Garden',
          ],
          'agentName': 'John Smith',
          'agentPhone': '+60 12-345 6789',
          'agentEmail': 'john.smith@example.com',
          'hasBalcony': true,
          'hasParking': true,
          'parkingSpots': 2,
          'landTitle': 'CL',
          'tenure': 'Leasehold',
          'leaseStatus': 'Active',
          'leaseTerm': '99 years',
          'isFeatured': true,
          'listedDate': DateTime.now().toIso8601String(),
        };
        break;

      case 'prop2':
        mockPropertyDetails = {
          'id': propertyId,
          'title': 'Jesselton Office Tower',
          'location': 'KK Times Square, Kota Kinabalu',
          'price': 3800000.0,
          'propertyType': 'Office',
          'bedrooms': 0,
          'bathrooms': 2,
          'imageUrl': 'https://images.unsplash.com/photo-1497366216548-37526070297c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2301&q=80',
          'squareFeet': 2500.0,
          'floorLevel': '15th Floor',
          'yearBuilt': 2020,
          'completionStatus': 'Ready',
          'furnishing': 'Fully Furnished',
          'description': '''
Premium office space in the heart of KK Times Square business district. This fully furnished office unit offers spectacular city views and modern amenities.

Features:
- Ready for immediate occupancy
- Modern office layout
- High-speed fiber internet ready
- 24/7 access with security
- Premium location with excellent connectivity
''',
          'listingType': 'For Sale',
          'propertyFacing': 'Sea View',
          'additionalImages': [
            'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&q=80&w=2340&h=1560&ixlib=rb-4.0.3',
            'https://images.unsplash.com/photo-1497215728101-856f4ea42174?auto=format&fit=crop&q=80&w=2340&h=1560&ixlib=rb-4.0.3',
            'https://images.unsplash.com/photo-1497366754035-f200968a6e72?auto=format&fit=crop&q=80&w=2340&h=1560&ixlib=rb-4.0.3',
          ],
          'amenities': [
            'Central Air-Conditioning',
            'High-Speed Elevators',
            '24/7 Security',
            'Covered Parking',
            'Meeting Rooms',
            'Pantry',
            'Building Management',
          ],
          'agentName': 'Sarah Lee',
          'agentPhone': '+60 16-789 0123',
          'agentEmail': 'sarah.lee@example.com',
          'hasBalcony': false,
          'hasParking': true,
          'parkingSpots': 2,
          'landTitle': 'CL',
          'tenure': 'Leasehold',
          'leaseStatus': 'Active',
          'leaseTerm': '99 years',
          'isFeatured': true,
          'listedDate': DateTime.now().toIso8601String(),
        };
        break;

      case 'prop3':
        mockPropertyDetails = {
          'id': propertyId,
          'title': 'Imago Shopping Mall Shop Lot',
          'location': 'Imago Mall, Kota Kinabalu',
          'price': 12000.0,
          'propertyType': 'Retail',
          'bedrooms': 0,
          'bathrooms': 1,
          'imageUrl': 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2340&q=80',
          'squareFeet': 1200.0,
          'floorLevel': 'Ground Floor',
          'yearBuilt': 2019,
          'completionStatus': 'Ready',
          'furnishing': 'Bare',
          'description': '''
Prime retail space available for rent in the popular Imago Shopping Mall. Located on the ground floor with high foot traffic and excellent visibility.

Features:
- Strategic corner lot position
- High ceiling height
- Suitable for F&B or retail
- Direct mall access
- Excellent frontage
''',
          'listingType': 'For Rent',
          'propertyFacing': 'Mall Interior',
          'additionalImages': [
            'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?auto=format&fit=crop&q=80&w=2340&h=1560&ixlib=rb-4.0.3',
            'https://images.unsplash.com/photo-1604014237800-1c9102c219da?auto=format&fit=crop&q=80&w=2340&h=1560&ixlib=rb-4.0.3',
            'https://images.unsplash.com/photo-1582037928769-181f2644ecb7?auto=format&fit=crop&q=80&w=2340&h=1560&ixlib=rb-4.0.3',
          ],
          'amenities': [
            'Central Air-Conditioning',
            'Loading Bay Access',
            '24/7 Security',
            'Grease Trap Ready',
            'Water Supply',
            'Power Supply',
            'Mall Management',
          ],
          'agentName': 'Michael Tan',
          'agentPhone': '+60 19-876 5432',
          'agentEmail': 'michael.tan@example.com',
          'hasBalcony': false,
          'hasParking': true,
          'parkingSpots': 1,
          'landTitle': 'CL',
          'tenure': 'Leasehold',
          'leaseStatus': 'Active',
          'leaseTerm': '99 years',
          'isFeatured': false,
          'listedDate': DateTime.now().toIso8601String(),
        };
        break;

      case 'prop4':
        mockPropertyDetails = {
          'id': propertyId,
          'title': 'Marina Court Luxury Condo',
          'location': 'Marina Court, Kota Kinabalu',
          'price': 850000.0,
          'propertyType': 'Condominium',
          'bedrooms': 3,
          'bathrooms': 2,
          'imageUrl': 'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2340&q=80',
          'squareFeet': 1250.0,
          'floorLevel': '12th Floor',
          'yearBuilt': 2018,
          'completionStatus': 'Ready',
          'furnishing': 'Fully Furnished',
          'description': '''
Luxurious condominium unit in the heart of Marina Court. This 3-bedroom residence offers stunning city views and modern amenities.

Features:
- Spacious living areas with high ceilings
- Modern kitchen with built-in appliances
- Master bedroom with walk-in wardrobe
- Private balcony with city views
- Covered parking for 2 cars
''',
          'listingType': 'For Sale',
          'propertyFacing': 'City View',
          'additionalImages': [
            'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&q=80&w=2340&h=1560&ixlib=rb-4.0.3',
            'https://images.unsplash.com/photo-1613977257363-707ba9348227?auto=format&fit=crop&q=80&w=2340&h=1560&ixlib=rb-4.0.3',
            'https://images.unsplash.com/photo-1613977257592-4871e5fcd7c4?auto=format&fit=crop&q=80&w=2340&h=1560&ixlib=rb-4.0.3',
          ],
          'amenities': [
            'Swimming Pool',
            'Gymnasium',
            'Security',
            'Covered Parking',
            'Garden',
          ],
          'agentName': 'Emily Wong',
          'agentPhone': '+60 17-654 3210',
          'agentEmail': 'emily.wong@example.com',
          'hasBalcony': true,
          'hasParking': true,
          'parkingSpots': 2,
          'landTitle': 'CL',
          'tenure': 'Leasehold',
          'leaseStatus': 'Active',
          'leaseTerm': '99 years',
          'isFeatured': true,
          'listedDate': DateTime.now().toIso8601String(),
        };
        break;

      case 'prop5':
        mockPropertyDetails = {
          'id': propertyId,
          'title': 'Riverson SOHO Suite',
          'location': 'Sembulan, Kota Kinabalu',
          'price': 2800.0,
          'propertyType': 'SOHO',
          'bedrooms': 1,
          'bathrooms': 1,
          'imageUrl': 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2340&q=80',
          'squareFeet': 750.0,
          'floorLevel': '8th Floor',
          'yearBuilt': 2021,
          'completionStatus': 'Ready',
          'furnishing': 'Fully Furnished',
          'description': '''
Modern SOHO suite in the heart of Sembulan. This 1-bedroom residence offers stunning city views and modern amenities.

Features:
- Spacious living areas with high ceilings
- Modern kitchen with built-in appliances
- Master bedroom with walk-in wardrobe
- Private balcony with city views
- Covered parking for 1 car
''',
          'listingType': 'For Rent',
          'propertyFacing': 'City View',
          'additionalImages': [
            'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?auto=format&fit=crop&q=80&w=2340&h=1560&ixlib=rb-4.0.3',
            'https://images.unsplash.com/photo-1604014237800-1c9102c219da?auto=format&fit=crop&q=80&w=2340&h=1560&ixlib=rb-4.0.3',
            'https://images.unsplash.com/photo-1582037928769-181f2644ecb7?auto=format&fit=crop&q=80&w=2340&h=1560&ixlib=rb-4.0.3',
          ],
          'amenities': [
            'Swimming Pool',
            'Gymnasium',
            'Security',
            'Covered Parking',
            'Garden',
          ],
          'agentName': 'David Lee',
          'agentPhone': '+60 19-876 5432',
          'agentEmail': 'david.lee@example.com',
          'hasBalcony': true,
          'hasParking': true,
          'parkingSpots': 1,
          'landTitle': 'CL',
          'tenure': 'Leasehold',
          'leaseStatus': 'Active',
          'leaseTerm': '99 years',
          'isFeatured': false,
          'listedDate': DateTime.now().toIso8601String(),
        };
        break;

      default:
        throw Exception('Property not found');
    }

    return PropertyDetail.fromJson(mockPropertyDetails);
  }
}
