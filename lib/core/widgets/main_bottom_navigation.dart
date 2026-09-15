import 'package:flutter/material.dart';

import 'package:food_nutrient_app/core/design_system/design_system.dart';

import '../../app/routes/app_routes.dart';
import 'app_bottom_navigation_bar.dart';

enum MainNavigationDestination {
  home,
  scan,
  search,
  saved,
  profile,
}

class MainBottomNavigation extends StatelessWidget {
  const MainBottomNavigation({
    this.currentDestination,
    super.key,
  });

  /// When null, the navigation bar is shown without selecting any item.
  /// This is useful on detail pages that are not one of the root sections.
  final MainNavigationDestination? currentDestination;

  static const _items = <AppBottomNavigationItem>[
    AppBottomNavigationItem(
      label: 'Home',
      icon: AppIcons.home_outlined,
      activeIcon: AppIcons.home_rounded,
    ),
    AppBottomNavigationItem(
      label: 'Scan',
      icon: AppIcons.center_focus_weak_rounded,
      activeIcon: AppIcons.center_focus_strong_rounded,
    ),
    AppBottomNavigationItem(
      label: 'Search',
      icon: AppIcons.search_rounded,
    ),
    AppBottomNavigationItem(
      label: 'Saved',
      icon: AppIcons.bookmark_border_rounded,
      activeIcon: AppIcons.bookmark_rounded,
    ),
    AppBottomNavigationItem(
      label: 'Profile',
      icon: AppIcons.person_outline_rounded,
      activeIcon: AppIcons.person_rounded,
    ),
  ];

  static const List<MainNavigationDestination> _destinations =
      MainNavigationDestination.values;

  int get _currentIndex => currentDestination == null
      ? -1
      : _destinations.indexOf(currentDestination!);

  @override
  Widget build(BuildContext context) {
    return AppBottomNavigationBar(
      items: _items,
      currentIndex: _currentIndex,
      onTap: (index) => _onDestinationSelected(
        context,
        _destinations[index],
      ),
    );
  }

  void _onDestinationSelected(
    BuildContext context,
    MainNavigationDestination destination,
  ) {
    if (destination == currentDestination) return;

    switch (destination) {
      case MainNavigationDestination.home:
        _openRootDestination(context, AppRoutes.home, clearAll: true);
        return;
      case MainNavigationDestination.scan:
        _openRootDestination(context, AppRoutes.scan);
        return;
      case MainNavigationDestination.search:
        _openRootDestination(context, AppRoutes.productSearch);
        return;
      case MainNavigationDestination.saved:
        _showSavedPlaceholder(context);
        return;
      case MainNavigationDestination.profile:
        _openRootDestination(context, AppRoutes.settings);
        return;
    }
  }

  void _openRootDestination(
    BuildContext context,
    String routeName, {
    bool clearAll = false,
  }) {
    final RoutePredicate predicate = clearAll
        ? (_) => false
        : (route) => route.settings.name == AppRoutes.home;

    Navigator.pushNamedAndRemoveUntil(
      context,
      routeName,
      predicate,
    );
  }

  void _showSavedPlaceholder(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Saved products are ready for API integration.'),
        ),
      );
  }
}
