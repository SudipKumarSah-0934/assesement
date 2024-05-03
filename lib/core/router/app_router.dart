import 'package:flutter/material.dart';
import 'package:genius_assesment/features/favorites/presentation/screens/favoritelist.dart';
import 'package:genius_assesment/features/search/presentation/pages/search_screen.dart';
import '../error/exceptions.dart';

sealed class AppRouter {
  static const String search = '/';

  static const String favoriteslist = '/favoriteslist';

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case search:
        return MaterialPageRoute(builder: (_) => const SearchScreen());

      case favoriteslist:
        return MaterialPageRoute(builder: (_) => const FavoriteListScreen());

      default:
        throw const RouteException('Route not found!');
    }
  }
}
