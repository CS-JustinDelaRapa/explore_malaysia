import 'package:explore_malaysia/models/property.dart';
import 'package:explore_malaysia/models/statistics.dart';

class AppState {
  final List<Property> properties;
  final List<Property> filteredProperties;
  final Map<String, dynamic> filters;
  final PropertyStatistics statistics;
  final bool isLoading;
  final String? error;

  AppState({
    required this.properties,
    required this.filteredProperties,
    required this.filters,
    required this.statistics,
    required this.isLoading,
    this.error,
  });

  factory AppState.initial() {
    return AppState(
      properties: [],
      filteredProperties: [],
      filters: {},
      statistics: PropertyStatistics.initial(),
      isLoading: false,
      error: null,
    );
  }

  AppState copyWith({
    List<Property>? properties,
    List<Property>? filteredProperties,
    Map<String, dynamic>? filters,
    PropertyStatistics? statistics,
    bool? isLoading,
    String? error,
  }) {
    return AppState(
      properties: properties ?? this.properties,
      filteredProperties: filteredProperties ?? this.filteredProperties,
      filters: filters ?? this.filters,
      statistics: statistics ?? this.statistics,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
