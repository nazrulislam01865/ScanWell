# ScanWell UI Alignment and Navigation Repair

## Scope

This repair was applied to the supplied `Archive 3.zip` project without adding dependencies or replacing the existing centralized design system.

## Root causes found

1. Health setup Step 1 called the dashboard directly unless `Other` was selected.
2. Health setup Step 2 also called the dashboard directly after submission.
3. The project displayed `1 of 3` / `2 of 3`, but had no Step 3 screen or route.
4. The signup login-method selector used a short fixed-height segment while `OTP login option` could wrap to two lines, causing clipping.
5. Dashboard stat and action cards used fixed card widths inside horizontal scrollers, which intentionally exposed partial cards on phone widths.
6. Several affected screens used forced newline characters, fixed heights, or ellipsis for text that should wrap naturally.
7. Settings rows allowed labels to wrap while trailing values and chevrons competed for horizontal space.
8. Health-concern tiles had fixed heights and ellipsis, which could crop long labels on narrow phones.

## Changes made

- Health setup now follows `Step 1 -> Step 2 -> Step 3 -> Dashboard` when Continue is used.
- Added `HealthProfileReadyScreen` as Step 3 with a dedicated named route.
- Step 2 can be skipped with `Skip for now`; both submit and skip advance to Step 3.
- Step 1 `Skip for now` retains its intentional direct-to-dashboard behavior.
- Signup auth selector keeps both labels to one responsive line and scales its height with text scale.
- Dashboard stat cards use a responsive in-viewport layout instead of a horizontal partial-card scroller.
- Dashboard action cards use responsive columns and natural text wrapping instead of cropped card content.
- Personalized-alert setup removed forced line breaks, removed title/concern ellipsis, and uses responsive card/tile constraints.
- Add-health-concern hero no longer uses a fixed-height overlapping Stack.
- Settings labels stay on one line and scale down only when the available width is genuinely too small.
- Health Profile and Notifications settings now open the existing personalized-alerts page instead of displaying placeholder messages.
- Added centralized semantic breakpoints for the repaired responsive layouts.

## Regression coverage added

- `test/health_setup_navigation_test.dart`
- `test/layout_regression_test.dart`
- `test/route_integrity_test.dart`
- Existing all-screen and responsive smoke suites now include Step 3.

The new tests cover 320, 360, 375, 390, and 412 logical-pixel phone widths for the screens reported in the screenshots.

## Verification performed in this environment

Source-level verification passed for:

- balanced Dart delimiters in library and test files,
- all centralized token references used by the modified code,
- all registered asset paths,
- all `AppRoutes` references and route switch cases,
- every presentation screen represented in smoke tests,
- every presentation screen represented by the central route file,
- design-system hard-code guard patterns,
- the repaired source-regression conditions.

The current execution environment does not contain Flutter or Dart, so `flutter analyze` and `flutter test` cannot be executed here. Run these after extracting the project on a Flutter machine:

```bash
flutter pub get
flutter analyze
flutter test
```
