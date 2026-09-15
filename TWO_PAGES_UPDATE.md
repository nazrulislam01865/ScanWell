# Product Scan and Product Search update

The two supplied interfaces are implemented as separate feature screens:

- `lib/features/consumer/presentation/scan_screen.dart`
- `lib/features/consumer/presentation/product_search_screen.dart`

The original contributor dashboard remains the application Home screen.

## Navigation

1. Login or email verification → Home / Contributor Dashboard
2. Dashboard Add Product → Product Scan
3. Scan quick action or Search tab → Product Search
4. Home tab → Contributor Dashboard
5. Profile tab → Settings → Privacy

The screens use responsive layouts and dummy frontend data while remaining
ready for later camera and API integration.
