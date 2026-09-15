# Responsive update

The frontend keeps the supplied mobile designs while adapting layout behavior
for compact Android phones, standard phones, landscape orientation, foldable
windows, and tablets.

## Main safeguards

- SafeArea is retained on every screen.
- Long pages remain vertically scrollable, including when the keyboard opens.
- Authentication and onboarding content is centered and width-limited on large
  screens so artwork and forms do not stretch.
- Compact screens receive reduced horizontal padding and typography only where
  needed to prevent clipping.
- OTP boxes calculate their width from available space.
- Dashboard statistics and action cards scroll horizontally on narrow screens.
- Dashboard header and impact content rearrange only when the available width
  cannot preserve the normal row layout.
- Fixed-height settings/privacy rows were replaced with minimum-height rows so
  wrapped text can expand safely.
- Bottom-navigation labels scale down inside their available item width.

## Test commands

```bash
flutter clean
flutter pub get
flutter analyze
flutter test
flutter run
```

The responsive widget test covers these logical viewport sizes:

- 320 x 568
- 360 x 640
- 390 x 844
- 844 x 390 (landscape)
- 800 x 1280 (tablet)
