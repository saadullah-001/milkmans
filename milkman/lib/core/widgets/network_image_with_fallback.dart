import 'package:flutter/material.dart';
import 'package:milkman/core/utils/assets.dart';

class NetworkImageWithFallback extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Alignment alignment;
  final String fallbackAsset;

  const NetworkImageWithFallback({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.alignment = Alignment.center,
    this.fallbackAsset = Assets.milkman,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          fallbackAsset,
          width: width,
          height: height,
          fit: fit,
          alignment: alignment,
        );
      },
    );
  }
}
