# ScanWell Design-System / Clean Architecture Refactor

## Goal

Centralize visual decisions without changing current behavior or appearance. The refactor is deliberately limited to presentation/design concerns: feature workflows, navigation behavior, dummy services, validation, state transitions, and user-facing copy remain unchanged.

## New folder structure

```text
lib/
├── app/
│   ├── app.dart
│   └── routes/
├── core/
│   ├── design_system/
│   │   ├── design_system.dart              # Public barrel API
│   │   ├── theme/
│   │   │   └── app_theme.dart              # ThemeData composition only
│   │   ├── typography/
│   │   │   └── app_typography.dart         # AppTextStyle + font metrics/weights
│   │   └── tokens/
│   │       ├── app_assets.dart              # Bundled image paths
│   │       ├── app_breakpoints.dart         # Responsive breakpoints/max width
│   │       ├── app_colors.dart              # Semantic + parity color palette
│   │       ├── app_elevation.dart           # Material elevation tokens
│   │       ├── app_icons.dart               # Central Material icon registry
│   │       ├── app_motion.dart              # UI animation durations
│   │       ├── app_opacity.dart             # Overlay/state opacity values
│   │       ├── app_radii.dart               # Corner radius scale
│   │       ├── app_shadows.dart             # Named BoxShadow/Shadow recipes
│   │       ├── app_sizes.dart               # Control/icon/layout dimensions
│   │       └── app_spacing.dart             # Padding/margin scale
│   ├── layout/
│   │   └── responsive_layout.dart           # Responsive policy, consumes tokens
│   ├── theme/
│   │   ├── app_colors.dart                  # Compatibility export only
│   │   └── app_theme.dart                   # Compatibility export only
│   └── widgets/                              # Reusable widgets consume DS only
└── features/
    └── ...                                   # Feature behavior preserved

test/
├── design_system/
│   ├── design_system_guard_test.dart         # Prevents hard-coded regressions
│   └── design_tokens_regression_test.dart    # Exact visual-value contracts
├── all_screens_smoke_test.dart               # Initial-render regression coverage
├── responsive_screens_test.dart              # Existing multi-device overflow tests
├── main_bottom_navigation_test.dart
└── widget_test.dart
```

## Layer responsibilities

### 1. Design tokens (`core/design_system/tokens`)
Own immutable visual primitives only. They do not know about screens, navigation, feature state, repositories, or services.

- `AppColors`: every color value.
- `AppSpacing`: padding/margin values.
- `AppSizes`: widget, control, image and icon dimensions.
- `AppRadii`: radius values.
- `AppIcons`: icon choices.
- `AppShadows`: complete named shadow recipes.
- `AppOpacity`: visual alpha values.
- `AppElevation`: Material elevation values.
- `AppMotion`: UI animation durations.
- `AppBreakpoints`: responsive thresholds.
- `AppAssets`: packaged asset paths.

The `toneXXXXXXXX` colors are intentional migration/parity tokens. Their names encode their exact ARGB value, which prevents accidental color drift. They can later be promoted to semantic names when the product design language is formally defined.

### 2. Typography (`core/design_system/typography`)
Owns the typography contract. `AppTypography` contains all sizes, weights, line heights, letter spacing, and decoration thickness. `AppTextStyle` is the only feature-facing `TextStyle` constructor.

The current application did not bundle a custom font. The refactor therefore intentionally retains Flutter's platform-default font. Introducing another font here would change glyph widths, wrapping, component height and screenshots and would violate the no-design-change requirement.

### 3. Theme (`core/design_system/theme`)
Maps tokens into Flutter `ThemeData`. It must not invent new feature values. Existing scaffold, divider, snack bar and input decoration behavior is preserved.

### 4. Shared layout/components (`core/layout`, `core/widgets`)
Reusable presentation code. These layers may consume the design-system public API, but must not define their own colors, fonts, icons, radii, shadows, or asset paths.

### 5. Feature presentation (`features/*/presentation`, `features/*/widgets`)
Owns screen composition and interaction only. Screens consume tokens and shared components. The guard test prevents visual constants from leaking back into features.

### 6. Feature data/state/services
Behavior and demo data were intentionally not redesigned. This minimizes regression risk. Existing workflow and auth behavior remains exactly where it was.

## Migration performed

1. Captured the existing visual constants before changing source files.
2. Created a stable `core/design_system/design_system.dart` public API.
3. Migrated the original `AppColors` and `AppTheme` into the design-system layer.
4. Preserved the old `core/theme/*` paths as compatibility exports to avoid breaking external/local imports.
5. Replaced literal colors with `AppColors` tokens without changing ARGB values.
6. Replaced direct `Icons.*` usage with `AppIcons` constants.
7. Replaced direct `TextStyle` creation with `AppTextStyle` and moved font size/weight/line-height/letter-spacing values to `AppTypography`.
8. Replaced padding/margin values with `AppSpacing`.
9. Replaced widget/icon/control dimensions with `AppSizes` where they are design dimensions.
10. Replaced literal radii with `AppRadii`.
11. Replaced local shadow definitions with named `AppShadows` recipes.
12. Centralized opacity, elevation, UI animation duration, breakpoints, and assets.
13. Updated `ResponsiveLayout` to consume centralized breakpoints/spacing while retaining the original thresholds and content width.
14. Added regression and architecture guard tests.

## Regression strategy

### Existing behavior tests retained
- Onboarding smoke behavior.
- Shared bottom navigation behavior.
- Responsive overflow coverage across 320x568, 360x640, 390x844, landscape 844x390, and tablet 800x1280.

### Added tests

`test/design_system/design_tokens_regression_test.dart`
- Locks core brand colors to original ARGB values.
- Locks spacing/radius/typography/breakpoint values.
- Locks shadow geometry.
- Locks asset/icon mappings.
- Locks the original `ThemeData` input-decoration contract.

`test/design_system/design_system_guard_test.dart`
- Fails if feature/shared UI code adds literal colors.
- Fails on direct `Colors.*` or `Icons.*` usage.
- Fails on local `TextStyle`, raw font sizes/weights, radii or shadow recipes.
- Fails on raw asset paths and common raw visual size/opacity/elevation values.

`test/all_screens_smoke_test.dart`
- Instantiates every current screen at the primary mobile viewport and catches initial-render exceptions after the migration.

## Required verification commands

Run these in a Flutter environment from the project root:

```bash
flutter pub get
flutter analyze
flutter test
```

For focused checks:

```bash
flutter test test/design_system/design_system_guard_test.dart
flutter test test/design_system/design_tokens_regression_test.dart
flutter test test/all_screens_smoke_test.dart
flutter test test/responsive_screens_test.dart
```

## Rules for future development

1. Import `package:food_nutrient_app/core/design_system/design_system.dart` instead of individual visual constants.
2. Never add `Color(0x...)`, `Colors.*`, or `Icons.*` inside feature/shared UI code.
3. Add any new visual primitive to the appropriate token file first.
4. Use `AppTextStyle` plus `AppTypography` tokens for local text composition.
5. Reuse `AppShadows` recipes rather than constructing shadows on screens.
6. Add bundled image paths to `AppAssets` first.
7. Do not change token values during structural refactors. Design changes should be separate commits so visual diffs are reviewable.
8. Keep business/network delays out of `AppMotion`; `AppMotion` is for visual animations only.

## Safe follow-up cleanup

After this parity migration is accepted visually, numeric parity tokens can be gradually renamed to semantic tokens (`titleLarge`, `controlHeight`, `cardRadius`, `contentGap`, etc.) one component family at a time. Do not combine that semantic cleanup with visual redesign.
