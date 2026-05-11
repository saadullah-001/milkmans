import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:milkman/app/di/di.dart';
import 'package:milkman/core/routing/app_router.dart';
import 'package:milkman/core/theme/extensions/context_ext.dart';
import 'package:milkman/core/theme/theme_cubit.dart';
import 'package:milkman/features/auth/presentation/cubits/session_cubit.dart';
import 'package:milkman/features/auth/presentation/cubits/auth_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final router = getIt<AppRouter>().router;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<ThemeCubit>()),
        BlocProvider(create: (_) => getIt<SessionCubit>()),
        BlocProvider(create: (_) => getIt<AuthBloc>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: router,
            darkTheme: state.darkTheme,
            theme: state.lightTheme,
            themeMode: state.mode,
            builder: (context, child) {
              final mq = MediaQuery.of(context);

              final scale = context.textScale;

              return MediaQuery(
                data: mq.copyWith(textScaler: TextScaler.linear(scale)),
                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}
