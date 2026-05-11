import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:milkman/core/routing/route_gaurds.dart';
import 'package:milkman/core/routing/route_path.dart';

class AppRouter {
  GoRouter get router => _router;

  late final GoRouter _router = GoRouter(
    initialLocation: RoutePaths.splash,
    routes: [
      GoRoute(
        path: RoutePaths.splash,
        builder: (context, state) => const _SplashScreen(),
      ),
      GoRoute(
        path: RoutePaths.login,
        builder: (context, state) => const _LoginScreen(),
      ),
      GoRoute(
        path: RoutePaths.home,
        redirect: (context, state) =>
            RouteGuards.requireAuth(state.uri.toString()),
        builder: (context, state) => const _HomeScreen(),
      ),
    ],
  );
}

/// TEMP placeholder screens (we’ll replace with real features next)
class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Splash')));
  }
}

class _LoginScreen extends StatelessWidget {
  const _LoginScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Login')));
  }
}

class _HomeScreen extends StatelessWidget {
  const _HomeScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Home')));
  }
}
