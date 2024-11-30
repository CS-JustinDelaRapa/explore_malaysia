import 'package:explore_malaysia/screens/property_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:explore_malaysia/store/app_state.dart';
import 'package:explore_malaysia/store/actions.dart';
import 'package:explore_malaysia/models/property.dart';
import 'package:go_router/go_router.dart';
import 'package:explore_malaysia/constants/colors.dart';
import 'package:explore_malaysia/services/property_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with SingleTickerProviderStateMixin {
  final _searchController = TextEditingController();
  String? _selectedPropertyType;
  int? _minBedrooms;
  late TabController _tabController;
  final _propertyService = PropertyService();
  List<Property> _featuredProperties = [];
  bool _isLoading = true;

  String? _selectedCompletion;
  int? _selectedBedrooms;
  int? _selectedBathrooms;
  String? _selectedFloorLevel;
  String? _selectedFurnishing;
  bool _forRent = true;
  bool _forSale = false;
  String? _selectedLeaseTerm;
  String? _selectedTenure;
  DateTime? _selectedYearBuilt;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadFeaturedProperties();
    StoreProvider.of<AppState>(context, listen: false).dispatch(fetchPropertiesThunk());
  }

  Future<void> _loadFeaturedProperties() async {
    try {
      final properties = await _propertyService.getFeaturedProperties();
      setState(() {
        _featuredProperties = properties;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Property> get _commercialProperties => 
    _featuredProperties.where((p) => p.propertyType.toLowerCase().contains('commercial') ||
        p.propertyType.toLowerCase().contains('office') ||
        p.propertyType.toLowerCase().contains('shop') ||
        p.propertyType.toLowerCase().contains('retail')).toList();

  List<Property> get _residentialProperties => 
    _featuredProperties.where((p) => !_commercialProperties.contains(p)).toList();

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => StatefulBuilder(
          builder: (context, setState) => Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Filter Options',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: AppColors.primary,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Common filters at top
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(labelText: 'Completion Status'),
                          value: _selectedCompletion,
                          items: ['Under Construction', 'Ready']
                              .map((status) => DropdownMenuItem(
                                    value: status,
                                    child: Text(status),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedCompletion = value;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(labelText: 'Furnishing'),
                          value: _selectedFurnishing,
                          items: ['Unfurnished', 'Partially Furnished', 'Fully Furnished']
                              .map((status) => DropdownMenuItem(
                                    value: status,
                                    child: Text(status),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedFurnishing = value;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        // Listing Type Toggle Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: _forRent
                                ? ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _forRent = false;
                                        if (!_forSale) _forSale = true;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text(
                                      'For Rent',
                                      style: TextStyle(color: AppColors.white),
                                    ),
                                  )
                                : OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        _forRent = true;
                                      });
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(color: AppColors.primary),
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text(
                                      'For Rent',
                                      style: TextStyle(color: AppColors.primary),
                                    ),
                                  ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _forSale
                                ? ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _forSale = false;
                                        if (!_forRent) _forRent = true;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text(
                                      'For Sale',
                                      style: TextStyle(color: AppColors.white),
                                    ),
                                  )
                                : OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        _forSale = true;
                                      });
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(color: AppColors.primary),
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text(
                                      'For Sale',
                                      style: TextStyle(color: AppColors.primary),
                                    ),
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Conditional dropdowns based on listing type in a row
                        Row(
                          children: [
                            if (_forRent)
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  decoration: const InputDecoration(labelText: 'Lease Term'),
                                  value: _selectedLeaseTerm,
                                  items: ['1 year', '2 years', '3 years', 'More than 3 years']
                                      .map((term) => DropdownMenuItem(
                                            value: term,
                                            child: Text(term),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedLeaseTerm = value;
                                    });
                                  },
                                ),
                              ),
                            if (_forRent && _forSale)
                              const SizedBox(width: 16),
                            if (_forSale)
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  decoration: const InputDecoration(labelText: 'Tenure Status'),
                                  value: _selectedTenure,
                                  items: ['Freehold', 'Leasehold']
                                      .map((status) => DropdownMenuItem(
                                            value: status,
                                            child: Text(status),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedTenure = value;
                                    });
                                  },
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Bedrooms and Bathrooms in a row
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<int>(
                                decoration: const InputDecoration(labelText: 'Bedrooms'),
                                value: _selectedBedrooms,
                                items: List.generate(10, (index) => index + 1)
                                    .map((count) => DropdownMenuItem(
                                          value: count,
                                          child: Text('$count+'),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedBedrooms = value;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: DropdownButtonFormField<int>(
                                decoration: const InputDecoration(labelText: 'Bathrooms'),
                                value: _selectedBathrooms,
                                items: List.generate(10, (index) => index + 1)
                                    .map((count) => DropdownMenuItem(
                                          value: count,
                                          child: Text('$count+'),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedBathrooms = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Floor Level and Year Built in a row
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                decoration: const InputDecoration(labelText: 'Floor Level'),
                                value: _selectedFloorLevel,
                                items: ['Low Floor', 'Mid Floor', 'High Floor']
                                    .map((level) => DropdownMenuItem(
                                          value: level,
                                          child: Text(level),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedFloorLevel = value;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: InkWell(
                                onTap: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Select Year'),
                                        content: SizedBox(
                                          height: 300,
                                          width: 300,
                                          child: YearPicker(
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime.now(),
                                            selectedDate: _selectedYearBuilt ?? DateTime.now(),
                                            onChanged: (DateTime dateTime) {
                                              setState(() {
                                                _selectedYearBuilt = dateTime;
                                              });
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: InputDecorator(
                                  decoration: const InputDecoration(
                                    labelText: 'Year Built',
                                    suffixIcon: Icon(Icons.calendar_today),
                                  ),
                                  child: Text(
                                    _selectedYearBuilt?.year.toString() ?? 'Select Year',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        //Action Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: ElevatedButton(
                                  onPressed: () {
                                    _applyAdvancedFilters();
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                  ),
                                  child: const Text(
                                    'Apply Filters',
                                    style: TextStyle(
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: OutlinedButton(
                                  onPressed: () {
                                    _resetAdvancedFilters();
                                    Navigator.pop(context);
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: AppColors.primary),
                                    foregroundColor: AppColors.primary,
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                  ),
                                  child: const Text('Reset'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _applyFilters() {
    final filters = {
      'location': _searchController.text,
      'propertyType': _selectedPropertyType,
      'minBedrooms': _minBedrooms,
    };

    StoreProvider.of<AppState>(context, listen: false).dispatch(filterPropertiesThunk(filters));
  }

  void _applyAdvancedFilters() {
    _loadFeaturedProperties();
  }

  void _resetAdvancedFilters() {
    setState(() {
      _selectedCompletion = null;
      _selectedBedrooms = null;
      _selectedBathrooms = null;
      _selectedFloorLevel = null;
      _selectedFurnishing = null;
      _forRent = true;
      _forSale = false;
      _selectedLeaseTerm = null;
      _selectedTenure = null;
      _selectedYearBuilt = null;
    });
    _loadFeaturedProperties();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Explore Malaysia',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 16,
            fontFamily: "TanAegean",
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.black,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.primary,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchBar(
                  controller: _searchController,
                  leading: const Icon(Icons.search, color: AppColors.primary),
                  trailing: [
                    IconButton(
                      icon: const Icon(Icons.tune, color: AppColors.primary),
                      onPressed: _showFilterOptions,
                    ),
                  ],
                  hintText: 'Search City, State or Area',
                  onChanged: (_) => _applyFilters(),
                  elevation: MaterialStateProperty.all<double>(0.0),
                  backgroundColor: MaterialStateProperty.all(AppColors.white),
                  side: MaterialStateProperty.all(
                    const BorderSide(color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ),
          TabBar(
            controller: _tabController,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.grey600,
            indicatorColor: AppColors.primary,
            tabs: const [
              Tab(text: 'Residential'),
              Tab(text: 'Commercial'),
            ],
          ),
          Expanded(
            child: _isLoading
              ? const Center(child: CircularProgressIndicator(color: AppColors.primary,))
              : TabBarView(
                  controller: _tabController,
                  children: [
                    _buildPropertyList(_residentialProperties),
                    _buildPropertyList(_commercialProperties),
                  ],
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyList(List<Property> properties) {
    if (properties.isEmpty) {
      return const Center(
        child: Text(
          'No properties found',
          style: TextStyle(
            color: AppColors.grey600,
            fontSize: 16,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
      itemCount: properties.length,
      itemBuilder: (context, index) {
        final property = properties[index];
        return _buildPropertyCard(property);
      },
    );
  }

  Widget _buildPropertyCard(Property property) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PropertyDetailScreen(propertyId: property.id),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                  child: Image.network(
                    property.imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                if (property.isFeatured)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: _buildChip(
                      label: 'Featured',
                      icon: Icons.star,
                      color: AppColors.primary,
                    ),
                  ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
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
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    property.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on, 
                        color: AppColors.grey600,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          property.location,
                          style: const TextStyle(
                            color: AppColors.grey600,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'RM ${property.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.king_bed, color: AppColors.primary),
                      const SizedBox(width: 4),
                      Text(
                        '${property.bedrooms}',
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.bathroom, color: AppColors.primary),
                      const SizedBox(width: 4),
                      Text(
                        '${property.bathrooms}',
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.square_foot, color: AppColors.primary),
                      const SizedBox(width: 4),
                      Text(
                        '${property.squareFeet.toStringAsFixed(0)} sq.ft',
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
}
