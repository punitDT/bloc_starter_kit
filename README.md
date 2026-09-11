# Bloc Starter Kit

A production-oriented Flutter starter kit built with Bloc, Go Router, secure storage, and a clean dependency-injection setup.

## Stack
- Flutter 3.47 / Dart 3.13+
- `flutter_bloc` + `bloc` + `equatable`
- `go_router` for typed navigation
- `dio` + `pretty_dio_logger` for HTTP and observability
- `flutter_secure_storage` + `shared_preferences` for secure and local persistence
- `get_it` for dependency injection

## Architecture
- `core/di` for service registration
- `core/router` for route configuration
- `core/theme` for theme setup
- `core/network` for API client and logging
- `features/splash` and `features/home` for feature-driven BLoC patterns

## Run locally
```bash
flutter pub get
flutter run
```

## Highlights
- Secure storage integration for sensitive tokens
- Dark/light theme persistence
- App bootstrap and dependency wiring
- Modular feature structure ready for scaling
