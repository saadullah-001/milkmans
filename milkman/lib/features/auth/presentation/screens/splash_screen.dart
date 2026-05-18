import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:milkman/core/routing/route_path.dart';
import 'package:milkman/core/theme/app_colors.dart';
import 'package:milkman/core/theme/app_dimens.dart';
import 'package:milkman/core/theme/extensions/text_ext.dart';
import 'package:milkman/core/utils/assets.dart';
import 'package:milkman/core/utils/string.dart';
import 'package:milkman/features/auth/presentation/cubits/session_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigateNext();
    });
  }

  Future<void> _navigateNext() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    final isAuthenticated = context.read<SessionCubit>().state.isAuthenticated;
    final nextRoute = isAuthenticated ? RoutePaths.home : RoutePaths.onboarding;
    context.go(nextRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.primaryDark],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 300),
            SizedBox(height: 200, child: Lottie.asset(Assets.cow)),
            const SizedBox(height: 50),
            Text(
              Strings.appName,
              style: context.text.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: AppDimens.softShadow(
                  dark: context.themeMode == ThemeMode.dark,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              Strings.moto,
              style: context.text.titleMedium?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 200),
            LoadingAnimationWidget.waveDots(color: Colors.white, size: 30),
            Text(
              'V1.0.0',
              style: context.text.bodySmall?.copyWith(
                color: Colors.white,
                letterSpacing: 2.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
