# Home/Dashboard and Scan merge fix

## Regression found

The later project changed successful authentication from `AppRoutes.dashboard`
to `AppRoutes.home`, and that Home route rendered the scanner interface. This
made the original contributor dashboard appear to be removed.

## Corrected mapping

- Home: `ContributorDashboardScreen`
- Legacy dashboard route: `ContributorDashboardScreen`
- Scan: `ScanScreen`
- Search: `ProductSearchScreen`
- Profile: `SettingsScreen`
- Privacy: `PrivacyScreen`

## Main changed files

- `lib/app/routes/app_routes.dart`
- `lib/features/consumer/presentation/scan_screen.dart`
- `lib/features/consumer/widgets/consumer_bottom_navigation.dart`
- `lib/features/dashboard/presentation/contributor_dashboard_screen.dart`
- `test/responsive_screens_test.dart`
