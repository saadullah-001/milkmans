import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:milkman/app/di/di.dart';
import 'package:milkman/core/routing/app_router.dart';
import 'package:milkman/core/theme/extensions/context_ext.dart';
import 'package:milkman/core/theme/theme_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final router = getIt<AppRouter>().router;
    return BlocProvider(
      create: (_) => getIt<ThemeCubit>(),
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
