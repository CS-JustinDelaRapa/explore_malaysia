import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/property_detail.dart';
import '../services/property_service.dart';

class PropertyDetailScreen extends StatefulWidget {
  final String propertyId;

  const PropertyDetailScreen({Key? key, required this.propertyId}) : super(key: key);

  @override
  State<PropertyDetailScreen> createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends State<PropertyDetailScreen> with SingleTickerProviderStateMixin {
  late Future<PropertyDetail> _propertyDetailsFuture;
  final PageController _pageController = PageController();
  late TabController _tabController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    final propertyService = PropertyService();
    _propertyDetailsFuture = propertyService.getPropertyDetails(widget.propertyId);
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildChip({
    required String label,
    IconData? icon,
    required Color color,
    EdgeInsets margin = EdgeInsets.zero,
  }) {
    return Container(
      margin: margin,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: Colors.white, size: 16),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutTab(PropertyDetail property) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildFeature(Icons.king_bed, '${property.bedrooms} Bedrooms'),
            _buildFeature(Icons.bathroom, '${property.bathrooms} Bathrooms'),
            _buildFeature(Icons.square_foot, '${property.squareFeet} sq.ft'),
          ],
        ),
        const SizedBox(height: 24),
        const Text(
          'Description',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          property.description,
          style: const TextStyle(
            color: AppColors.grey600,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Additional Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildDetailRow('Furnishing', property.furnishing),
        _buildDetailRow('Floor Level', property.floorLevel),
        _buildDetailRow('Year Built', property.yearBuilt.toString()),
        _buildDetailRow('Property Facing', property.propertyFacing),
        _buildDetailRow('Parking Spots', property.parkingSpots.toString()),
        _buildDetailRow('Land Title', property.landTitle),
        _buildDetailRow('Tenure', property.tenure),
        if (property.leaseStatus != null)
          _buildDetailRow('Lease Status', property.leaseStatus!),
        if (property.leaseTerm != null)
          _buildDetailRow('Lease Term', property.leaseTerm!),
        const SizedBox(height: 24),
        const Text(
          'Amenities',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: property.amenities.map((amenity) {
            return Chip(
              label: Text(amenity),
              backgroundColor: AppColors.primary.withOpacity(0.1),
              labelStyle: const TextStyle(color: AppColors.primary),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
        const Text(
          'Listed By',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            backgroundColor: AppColors.primary,
            child: Text(
              property.agentName[0],
              style: const TextStyle(color: Colors.white),
            ),
          ),
          title: Text(property.agentName),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(property.agentPhone),
              Text(property.agentEmail),
            ],
          ),
        ),
        // Add extra padding at the bottom to account for the sticky button
        const SizedBox(height: 80),
      ],
    );
  }

  Widget _buildMapTab(PropertyDetail property) {
    return Column(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Stack(
              children: [
                // Map background grid
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 20,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 1,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.white.withOpacity(0.5),
                    );
                  },
                  itemCount: 400,
                ),
                // Roads
                CustomPaint(
                  size: const Size(double.infinity, double.infinity),
                  painter: RoadPainter(),
                ),
                // Location marker
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Property Location',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Zoom controls
                Positioned(
                  right: 16,
                  bottom: 16,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {},
                              color: AppColors.grey600,
                            ),
                            Container(
                              height: 1,
                              color: Colors.grey[300],
                            ),
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {},
                              color: AppColors.grey600,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 80), // For bottom button spacing
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<PropertyDetail>(
        future: _propertyDetailsFuture,
        builder: (context, snapshot) {
          if (!mounted) return Container();

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary,));
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('Property not found'));
          }

          final property = snapshot.data!;
          final allImages = [property.imageUrl, ...property.additionalImages];

          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 200,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          PageView.builder(
                            controller: _pageController,
                            onPageChanged: (index) {
                              setState(() {
                                _currentPage = index;
                              });
                            },
                            itemCount: allImages.length,
                            itemBuilder: (context, index) {
                              return Image.network(
                                allImages[index],
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                          Positioned(
                            bottom: 16,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                allImages.length,
                                (index) => Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 4),
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _currentPage == index
                                        ? AppColors.primary
                                        : Colors.white.withOpacity(0.5),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 60,
                            right: 16,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                if(property.isFeatured)
                                _buildChip(
                                  label: 'Featured',
                                  icon: Icons.star,
                                  color: AppColors.primary,
                                  margin: const EdgeInsets.only(bottom: 4),
                                ),
                                _buildChip(
                                  label: property.listingType,
                                  icon: property.listingType == 'For Sale' ? Icons.sell : Icons.key,
                                  color: Colors.black.withOpacity(0.5),
                                  margin: const EdgeInsets.only(bottom: 4),
                                ),
                                _buildChip(
                                  label: property.completionStatus,
                                  icon: property.completionStatus == 'Ready' ? Icons.check_circle : Icons.pending,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            property.title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.location_on, color: AppColors.grey600, size: 16,),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  property.location,
                                  style: const TextStyle(
                                    color: AppColors.grey600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'RM ${property.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TabBar(
                            controller: _tabController,
                            labelColor: AppColors.primary,
                            unselectedLabelColor: AppColors.grey600,
                            indicatorColor: AppColors.primary,
                            tabs: const [
                              Tab(text: 'About'),
                              Tab(text: 'Map'),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.47, // Adjust this value as needed
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                SingleChildScrollView(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: _buildAboutTab(property)),
                                _buildMapTab(property),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, -3),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Implement contact agent functionality
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Contact Agent',
                      style: TextStyle(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFeature(IconData icon, String text) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary),
        const SizedBox(height: 4),
        Text(
          text,
          style: const TextStyle(
            color: AppColors.grey600,
          ),
        ),
      ],
    );
  }
}

// Custom painter for drawing roads
class RoadPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[400]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Horizontal road
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      paint,
    );

    // Vertical road
    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      paint,
    );

    // Draw smaller roads
    final dashPaint = Paint()
      ..color = Colors.grey[350]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Additional horizontal roads
    canvas.drawLine(
      Offset(0, size.height / 3),
      Offset(size.width, size.height / 3),
      dashPaint,
    );
    canvas.drawLine(
      Offset(0, size.height * 2 / 3),
      Offset(size.width, size.height * 2 / 3),
      dashPaint,
    );

    // Additional vertical roads
    canvas.drawLine(
      Offset(size.width / 3, 0),
      Offset(size.width / 3, size.height),
      dashPaint,
    );
    canvas.drawLine(
      Offset(size.width * 2 / 3, 0),
      Offset(size.width * 2 / 3, size.height),
      dashPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
