import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:milkman/core/routing/route_gaurds.dart';
import 'package:milkman/core/routing/route_path.dart';
import 'package:milkman/features/auth/presentation/screens/login_screen.dart';
<<<<<<< Updated upstream
import 'package:milkman/features/auth/presentation/screens/splash_screen.dart';
import 'package:milkman/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:milkman/features/auth/presentation/screens/otp_verification_screen.dart';
import 'package:milkman/features/home/presentation/screens/home_screen.dart';
=======
import 'package:milkman/features/auth/presentation/screens/register_screen.dart';
import 'package:milkman/features/home/home_screen.dart';
>>>>>>> Stashed changes

class AppRouter {
  GoRouter get router => _router;

  late final GoRouter _router = GoRouter(
    initialLocation: RoutePaths.splash,
    redirect: _handleRedirect,
    routes: [
      GoRoute(
        path: RoutePaths.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RoutePaths.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: RoutePaths.login,
        builder: (context, state) => const LoginScreen(),
      ),

      GoRoute(
        path: '${RoutePaths.otpVerification}/:phoneNumber',
        builder: (context, state) => OTPVerificationScreen(
          phoneNumber: state.pathParameters['phoneNumber'] ?? '',
        ),
      ),
      GoRoute(
        path: RoutePaths.home,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );

  String? _handleRedirect(BuildContext context, GoRouterState state) {
    final isAuthenticated = RouteGuards.isLoggedIn;
    final isAuthRoute =
        state.uri.path == RoutePaths.login ||
        state.uri.path == RoutePaths.register ||
        state.uri.path.startsWith(RoutePaths.otpVerification);
    final isSplashRoute = state.uri.path == RoutePaths.splash;
    final isOnboardingRoute = state.uri.path == RoutePaths.onboarding;

    if (!isAuthenticated &&
        !(isSplashRoute || isOnboardingRoute || isAuthRoute)) {
      return RoutePaths.login;
    }

    if (isAuthenticated && isAuthRoute) {
      return RoutePaths.home;
    }

    return null;
  }
}
<<<<<<< Updated upstream
=======

/// Splash screen - placeholder
class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

/// Home screen - placeholder
>>>>>>> Stashed changes
