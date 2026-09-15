# ScanWell Flutter Frontend

A lightweight Flutter frontend implementing the supplied ScanWell onboarding,
authentication, contributor dashboard, settings, and privacy designs.

## Screen sequence

1. Onboarding `1 of 3` — Scan packaged products
2. Onboarding `2 of 3` — Understand health flags
3. Onboarding `3 of 3` — Personalized for your health
4. Create Account or Login
5. Verify Email for signup or OTP login
6. Home / Contributor Dashboard
7. Add Product or Scan navigation → Product Scan
8. Search Product → Product Search
9. Profile tab → Settings
10. Settings → Privacy

## Dummy authentication

No backend is required to test the flow.

- Password login: use any valid email and any password with at least 6 characters.
- Example email: `aminul@gmail.com`
- Example password: `123456`
- Signup: complete the form and continue to verification.
- OTP/email verification code: `123456`
- Tapping **Resend code** also shows the demo code in a snackbar.

## Run

```bash
flutter pub get
flutter run
```

## Structure

- `lib/app`: app setup and named routes
- `lib/core`: theme and reusable widgets
- `lib/features/onboarding`: ordered onboarding data and UI
- `lib/features/auth`: dummy auth data layer and authentication screens
- `lib/features/dashboard`: Home/contributor dashboard and submission models
- `lib/features/consumer`: product scan, product search, consumer data, and shared navigation
- `lib/features/settings`: settings, privacy, and profile navigation
- `assets/images`: visual assets prepared from the supplied references

The frontend is ready for later API integration. Forms, validation, password
visibility, OTP input, navigation, responsive scrolling, settings actions, and
privacy actions are functional as frontend interactions.

## Responsive layout support

The screens are optimized for compact Android phones, standard phones,
landscape orientation, foldable window sizes, and tablets. Large screens keep
the original phone composition centered instead of stretching it. All long
screens scroll, Safe Areas are respected, and form screens remain usable while
the keyboard is open.

Run the responsive smoke tests with:

```bash
flutter test test/responsive_screens_test.dart
```


## Corrected Home and Scan mapping

The Home route keeps the original contributor dashboard. The product scanning
interface is a separate `ScanScreen` and is no longer used as the Home screen.
The product search screen remains separate.

- `/home` and `/dashboard` → `ContributorDashboardScreen`
- `/scan` → `ScanScreen`
- `/product-search` → `ProductSearchScreen`
- successful dummy login or verification → `/home`

The dashboard's **Add Product** destination opens the Scan screen. From the
consumer bottom navigation, **Home** returns to the dashboard, **Scan** opens
the scanner page, **Search** opens product search, and **Profile** opens
Settings.
