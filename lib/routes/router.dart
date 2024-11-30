import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:explore_malaysia/screens/home_screen.dart';
import 'package:explore_malaysia/screens/search_screen.dart';
import 'package:explore_malaysia/screens/property_detail_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      path: '/property/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'];
        return PropertyDetailScreen(propertyId: id ?? '');
      },
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Error: ${state.error}'),
    ),
  ),
);
