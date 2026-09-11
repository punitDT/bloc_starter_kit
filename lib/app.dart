import 'package:bloc_starter_kit/core/di/injection.dart';
import 'package:bloc_starter_kit/core/l10n/l10n_setup.dart';
import 'package:bloc_starter_kit/core/router/app_router.dart';
import 'package:bloc_starter_kit/core/theme/app_theme.dart';
import 'package:bloc_starter_kit/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = getIt<AppRouter>();
    final homeCubit = getIt<HomeCubit>();

    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(create: (_) => homeCubit),
      ],
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Bloc Starter Kit',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: state.themeMode,
            locale: state.locale,
            supportedLocales: L10nSetup.supportedLocales,
            localizationsDelegates: L10nSetup.localizationsDelegates,
            routerConfig: appRouter.config(),
          );
        },
      ),
    );
  }
}
