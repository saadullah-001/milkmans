import 'package:flutter/material.dart';
import 'package:milkman/core/theme/app_colors.dart';
import 'package:milkman/core/theme/app_dimens.dart';

class MilkPlanCard extends StatelessWidget {
  final String title;
  final String badge;
  final String description;
  final String price;
  final String frequency;
  final Color accentColor;
  final bool highlighted;

  const MilkPlanCard({
    super.key,
    required this.title,
    required this.badge,
    required this.description,
    required this.price,
    required this.frequency,
    required this.accentColor,
    this.highlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: highlighted
            ? AppColors.primary.withOpacity(0.08)
            : Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: highlighted
              ? AppColors.primary.withOpacity(0.25)
              : Colors.transparent,
          width: 1.2,
        ),
        boxShadow: AppDimens.softShadow(),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.16),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              badge.toUpperCase(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: accentColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textMuted,
              height: 1.45,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\$$price',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    frequency,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: highlighted
                      ? AppColors.primary
                      : AppColors.primary.withOpacity(0.12),
                  foregroundColor: highlighted
                      ? Colors.white
                      : AppColors.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                ),
                child: Text(
                  'Subscribe',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: highlighted ? Colors.white : AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
