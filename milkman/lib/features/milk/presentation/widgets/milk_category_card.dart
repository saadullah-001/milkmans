import 'package:flutter/material.dart';
import 'package:milkman/core/theme/app_colors.dart';
import 'package:milkman/core/theme/app_dimens.dart';
import 'package:milkman/core/widgets/network_image_with_fallback.dart';

class MilkCategoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double price;
  final String imageUrl;
  final Color accentColor;
  final VoidCallback? onTap;
  final VoidCallback? onAdd;

  const MilkCategoryCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.imageUrl,
    required this.accentColor,
    this.onTap,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: AppDimens.softShadow(),
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: NetworkImageWithFallback(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: accentColor.withOpacity(0.18),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.add, color: accentColor, size: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'PKR ${price.toStringAsFixed(0)}',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    onTap: onAdd,
                    child: Icon(Icons.add, color: accentColor, size: 20),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
