import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:milkman/core/routing/route_gaurds.dart';
import 'package:milkman/core/routing/route_path.dart';
import 'package:milkman/features/auth/presentation/cubits/session_cubit.dart';
import 'package:milkman/features/auth/presentation/screens/login_screen.dart';
import 'package:milkman/features/auth/presentation/screens/register_screen.dart';

class AppRouter {
  GoRouter get router => _router;

  late final GoRouter _router = GoRouter(
    initialLocation: RoutePaths.splash,
    redirect: _handleRedirect,
    routes: [
      GoRoute(
        path: RoutePaths.splash,
        builder: (context, state) => const _SplashScreen(),
      ),
      GoRoute(
        path: RoutePaths.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RoutePaths.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: RoutePaths.home,
        builder: (context, state) => const _HomeScreen(),
      ),
    ],
  );

  String? _handleRedirect(BuildContext context, GoRouterState state) {
    final isAuthenticated = RouteGuards.isLoggedIn;
    final isLoggingIn =
        state.uri.path == RoutePaths.login ||
        state.uri.path == RoutePaths.register;

    if (!isAuthenticated && !isLoggingIn) {
      return RoutePaths.login;
    }

    if (isAuthenticated && isLoggingIn) {
      return RoutePaths.home;
    }

    return null;
  }
}

/// Splash screen - placeholder
class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

/// Home screen - placeholder
class _HomeScreen extends StatelessWidget {
  const _HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<SessionCubit, SessionState>(
              builder: (context, state) {
                return Text('Welcome, ${state.user?.displayName ?? 'User'}!');
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.read<SessionCubit>().logout(),
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
