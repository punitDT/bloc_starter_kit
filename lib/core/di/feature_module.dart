import 'package:bloc_starter_kit/core/storage/preferences.dart';
import 'package:bloc_starter_kit/core/storage/secure_storage.dart';
import 'package:bloc_starter_kit/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:bloc_starter_kit/features/auth/domain/repositories/auth_repository.dart';
import 'package:bloc_starter_kit/features/home/presentation/cubit/home_cubit.dart';
import 'package:injectable/injectable.dart';

/// Feature-level dependency registrations.
///
/// `LoginUseCase`, `LogoutUseCase` and `AuthCubit` are registered via
/// their own injectable annotations to avoid duplicate bindings.
@module
abstract class FeatureModule {
  /// Auth repository bound to its interface.
  @LazySingleton(as: AuthRepository)
  AuthRepositoryImpl authRepository(SecureStorage secureStorage) =>
      AuthRepositoryImpl(secureStorage);

  /// Theme/locale holder alive for app lifetime.
  @singleton
  HomeCubit homeCubit(Preferences preferences) => HomeCubit(preferences);
}
