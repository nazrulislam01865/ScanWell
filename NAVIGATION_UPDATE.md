# Shared bottom navigation update

The app now uses one reusable bottom navigation component on every main screen.

## Destinations

1. Home
2. Scan
3. Search
4. Saved
5. Profile

## Reusable files

- `lib/core/widgets/app_bottom_navigation_bar.dart`
  - Generic visual renderer for any bottom navigation item list.
- `lib/core/widgets/main_bottom_navigation.dart`
  - Defines the app-wide destinations, icons, selected state, and route behavior.

## Screens using the shared component

- Contributor dashboard / Home
- Scan
- Product Search
- Settings / Profile
- Privacy

The dashboard no longer declares a separate `Add Product` bottom-navigation item. Its existing `Add New Product` dashboard action card remains and correctly opens the Scan screen.

## Removed duplicate files

- `lib/features/consumer/widgets/consumer_bottom_navigation.dart`
- `lib/features/settings/widgets/consumer_bottom_navigation.dart`

## Test

`test/main_bottom_navigation_test.dart` verifies the shared labels and Scan navigation behavior.
