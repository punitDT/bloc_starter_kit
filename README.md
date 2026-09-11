# Bloc Starter Kit

A production-grade Flutter starter kit built with BLoC, Clean Architecture, and Material 3.

## Features

- Feature-first Clean Architecture (Domain / Data / Presentation)
- BLoC state management with `flutter_bloc` + HydratedBloc (theme/locale persistence)
- GoRouter navigation with `ShellRoute` bottom-tab shell
- `get_it` + `injectable` dependency injection (generated)
- Material 3 theming (light/dark/system), semantic color tokens
- Localization (English + Arabic) via ARB + `flutter gen-l10n`
- Freezed-style immutable BLoC states with failure hierarchies (`fpdart` `Either`)
- Strict linting via `very_good_analysis`
- Flavor entry points: `main_dev.dart`, `main_prod.dart` with envied (obfuscated env)

## Home Screen

The home screen AppBar is titled **"Bloc Starter Kit"** (defined in `assets/l10n/app_en.arb` → `homeTitle`).

## Getting Started

```sh
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter gen-l10n
flutter run
```

## Code Generation

Generated files (`*.g.dart`, `*.freezed.dart`, `injection.config.dart`) are committed per spec — CI does not run build_runner as part of the build.

## Project Structure

```
lib/
├── core/                  # DI, router, network, theme, storage, utils, widgets
│   ├── di/                # get_it + injectable setup
│   ├── router/            # GoRouter + route constants
│   ├── network/           # Dio, failure hierarchy, NetworkInfo
│   ├── theme/             # AppColors, AppTextStyles, AppTheme
│   ├── l10n/              # Generated localizations
│   └── widgets/           # Shared design-system widgets
├── features/
│   ├── splash/            # SplashPage
│   ├── onboarding/        # Multi-step onboarding
│   ├── auth/              # login/register/forgot-password
│   ├── home/              # HomeShell + HomePage (Bloc Starter Kit title)
│   ├── profile/           # Profile + edit
│   ├── settings/          # Theme/language switches
│   ├── notifications/     # Notifications list
│   └── error/             # 404 + no-internet pages
└── main.dart / main_dev.dart / main_prod.dart
```

Each feature follows `domain/` (entities, interfaces, use cases), `data/` (repos, models), `presentation/` (BLoC, pages, widgets).

## Verification

```sh
flutter analyze        # zero warnings
flutter test           # widget tests pass
flutter build web      # compiles
```