import 'package:flutter/material.dart';
import 'package:milkman/core/theme/app_colors.dart';

class MilkmanTopHeader extends StatelessWidget {
  final Widget? child;
  final double heightFactor; // responsive height
  final double opacity;

  const MilkmanTopHeader({
    super.key,
    this.child,
    this.heightFactor = 0.32, // 32% of screen
    this.opacity = 1,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    int alpha = (opacity * 255).round();

    final colors = [
      AppColors.primary.withAlpha(alpha),
      AppColors.primaryDark.withAlpha(alpha),
    ];

    return ClipPath(
      clipper: _HeaderClipper(),
      child: Container(
        height: size.height * heightFactor,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: child,
      ),
    );
  }
}

class _HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0, size.height - 60);

    final firstControlPoint = Offset(size.width * 0.25, size.height);
    final firstEndPoint = Offset(size.width * 0.5, size.height - 40);

    final secondControlPoint = Offset(size.width * 0.75, size.height - 100);
    final secondEndPoint = Offset(size.width, size.height - 50);

    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
