import 'package:flutter/material.dart';
import 'package:cashier/screens/pos_screen.dart';
import 'package:cashier/screens/management_screen.dart';
import 'package:cashier/screens/sales_history_screen.dart';
import 'package:cashier/screens/cash_transaction_screen.dart';

/// Represents a single route configuration
class AppRoute {
  final String path;
  final String name;
  final WidgetBuilder builder;

  const AppRoute({
    required this.path,
    required this.name,
    required this.builder,
  });
}

/// Centralized route definitions for the application
class AppRoutes {
  // Route paths
  static const String pos = '/';
  static const String management = '/management';
  static const String salesHistory = '/sales-history';
  static const String cashTransaction = '/cash-transaction';

  // Route configurations
  static final List<AppRoute> _routes = [
    AppRoute(path: pos, name: 'POS', builder: (context) => const PosScreen()),
    AppRoute(
      path: management,
      name: 'Management',
      builder: (context) => const ManagementScreen(),
    ),
    AppRoute(
      path: salesHistory,
      name: 'Riwayat penjualan',
      builder: (context) => const SalesHistoryScreen(),
    ),
    AppRoute(
      path: cashTransaction,
      name: 'Uang Masuk / Keluar',
      builder: (context) => const CashTransactionScreen(),
    ),
  ];

  /// Get all route configurations
  static List<AppRoute> get all => _routes;

  /// Generate routes map for MaterialApp
  static Map<String, WidgetBuilder> get routeMap => {
    for (final route in _routes) route.path: route.builder,
  };

  /// Find route by path
  static AppRoute? findByPath(String path) {
    try {
      return _routes.firstWhere((r) => r.path == path);
    } catch (_) {
      return null;
    }
  }
}
