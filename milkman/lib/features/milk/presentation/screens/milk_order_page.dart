import 'package:flutter/material.dart';
import 'package:milkman/core/theme/app_colors.dart';
import 'package:milkman/features/milk/presentation/widgets/custom_appbar.dart';
import 'package:milkman/features/milk/presentation/widgets/milk_category_card.dart';
import 'package:milkman/features/milk/presentation/widgets/milk_farm_card.dart';
import 'package:milkman/features/milk/presentation/widgets/milk_hero_banner.dart';
import 'package:milkman/features/milk/presentation/widgets/milk_plan_card.dart';
import 'package:milkman/features/milk/presentation/widgets/milk_product_card.dart';
import 'package:milkman/features/milk/presentation/widgets/milk_section_header.dart';
import 'package:milkman/features/milk/presentation/screens/product_detail_page.dart';
import 'package:milkman/features/milk/presentation/screens/cart_page.dart';

class MilkOrderPage extends StatelessWidget {
  const MilkOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scale = (size.width / 375).clamp(0.85, 1.15);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final categories = [
      {
        'title': 'Cow Milk',
        'subtitle': 'Organic & Fresh',
        'price': 450.0,
        'image':
            'https://images.unsplash.com/photo-1563805042-7684e30349b9?auto=format&fit=crop&w=800&q=80',
        'accent': AppColors.primary,
      },
      {
        'title': 'Buffalo Milk',
        'subtitle': 'Rich & Creamy',
        'price': 520.0,
        'image':
            'https://images.unsplash.com/photo-1584405872624-304014f8e4b7?auto=format&fit=crop&w=800&q=80',
        'accent': AppColors.organic,
      },
      {
        'title': 'Goat Milk',
        'subtitle': 'Light & Nutritious',
        'price': 600.0,
        'image':
            'https://images.unsplash.com/photo-1576841829337-48e8a8b33435?auto=format&fit=crop&w=800&q=80',
        'accent': const Color(0xFF7C4DFF),
      },
      {
        'title': 'Camel Milk',
        'subtitle': 'Exotic & Healthy',
        'price': 1200.0,
        'image':
            'https://images.unsplash.com/photo-1528825871115-3581a5387919?auto=format&fit=crop&w=800&q=80',
        'accent': const Color(0xFFFFA726),
      },
    ];

    final plans = [
      {
        'title': 'Morning Essentials',
        'badge': 'Daily Morning',
        'description': 'Milk, Eggs & Bread daily by 7AM.',
        'price': '99',
        'frequency': '/mo',
        'accent': AppColors.primary,
        'highlighted': true,
      },
      {
        'title': 'Family Feast',
        'badge': 'Weekend Special',
        'description': 'Premium cheese & meats for BBQ.',
        'price': '160',
        'frequency': '/mo',
        'accent': const Color(0xFF5E35B1),
        'highlighted': false,
      },
    ];

    final products = [
      {
        'name': 'Pure Goat Milk',
        'subtitle': '1 Liter Bottle',
        'price': '6.00',
        'image':
            'https://images.unsplash.com/photo-1576841829337-48e8a8b33435?auto=format&fit=crop&w=800&q=80',
      },
      {
        'name': 'Salted Butter',
        'subtitle': '200g Pack',
        'price': '3.50',
        'image':
            'https://images.unsplash.com/photo-1557312560-8a588c1440bb?auto=format&fit=crop&w=800&q=80',
      },
      {
        'name': 'Organic Eggs',
        'subtitle': 'Pack of 6',
        'price': '4.20',
        'image':
            'https://images.unsplash.com/photo-1518976024611-488217f783e2?auto=format&fit=crop&w=800&q=80',
      },
    ];

    final farms = [
      {
        'name': 'Sunny Pastures',
        'distance': '2.3 mi',
        'description': 'Specializes in grass-fed cow milk and aged cheese.',
        'rating': 4.8,
        'reviews': 120,
        'image':
            'https://images.unsplash.com/photo-1496497240881-0831cd7f53bc?auto=format&fit=crop&w=800&q=80',
      },
      {
        'name': 'River Organics',
        'distance': '4.1 mi',
        'description': 'Certified organic goat milk and fresh yogurt.',
        'rating': 4.9,
        'reviews': 85,
        'image':
            'https://images.unsplash.com/photo-1547394765-2b36b3db9b73?auto=format&fit=crop&w=800&q=80',
      },
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              userName: 'Alex Johnson',
              location: 'Green Valley, NY',
              onCartTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CartPage()),
                );
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MilkHeroBanner(
                      title: 'Urgent Delivery Today',
                      subtitle: 'Fresh morning milk before 10 AM.',
                      label: 'Order Now',
                      imageUrl:
                          'https://images.unsplash.com/photo-1542736667-069246bdbc6d?auto=format&fit=crop&w=700&q=80',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const CartPage()),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    MilkSectionHeader(
                      title: 'Fresh Categories',
                      actionLabel: 'View All',
                      onAction: () {},
                    ),
                    const SizedBox(height: 14),
                    GridView.builder(
                      itemCount: categories.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: size.width > 450 ? 4 : 2,
                        mainAxisSpacing: 14,
                        crossAxisSpacing: 14,
                        childAspectRatio: 0.74,
                      ),
                      itemBuilder: (context, index) {
                        final item = categories[index];
                        return MilkCategoryCard(
                          title: item['title']! as String,
                          subtitle: item['subtitle']! as String,
                          price: item['price']! as double,
                          imageUrl: item['image']! as String,
                          accentColor: item['accent']! as Color,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProductDetailPage(
                                  id: item['title']! as String,
                                  name: item['title']! as String,
                                  subtitle: item['subtitle']! as String,
                                  price: item['price']! as double,
                                  imageUrl: item['image']! as String,
                                ),
                              ),
                            );
                          },
                          onAdd: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProductDetailPage(
                                  id: item['title']! as String,
                                  name: item['title']! as String,
                                  subtitle: item['subtitle']! as String,
                                  price: item['price']! as double,
                                  imageUrl: item['image']! as String,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    MilkSectionHeader(
                      title: 'Subscription Plans',
                      actionLabel: 'See All',
                      onAction: () {},
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      height: 210,
                      child: ListView.separated(
                        itemCount: plans.length,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (_, __) => const SizedBox(width: 14),
                        itemBuilder: (context, index) {
                          final plan = plans[index];
                          return MilkPlanCard(
                            title: plan['title']! as String,
                            badge: plan['badge']! as String,
                            description: plan['description']! as String,
                            price: plan['price']! as String,
                            frequency: plan['frequency']! as String,
                            accentColor: plan['accent']! as Color,
                            highlighted: plan['highlighted']! as bool,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    MilkSectionHeader(
                      title: 'Popular Right Now',
                      actionLabel: 'Browse',
                      onAction: () {},
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      height: 220,
                      child: ListView.separated(
                        itemCount: products.length,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (_, __) => const SizedBox(width: 14),
                        itemBuilder: (context, index) {
                          final product = products[index];
                          final double price =
                              double.tryParse(product['price']!) ?? 0.0;
                          return MilkProductCard(
                            name: product['name']!,
                            subtitle: product['subtitle']!,
                            price: price,
                            imageUrl: product['image']!,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProductDetailPage(
                                  id: product['name']!,
                                  name: product['name']!,
                                  subtitle: product['subtitle']!,
                                  price: price,
                                  imageUrl: product['image']!,
                                ),
                              ),
                            ),
                            onAdd: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProductDetailPage(
                                  id: product['name']!,
                                  name: product['name']!,
                                  subtitle: product['subtitle']!,
                                  price: price,
                                  imageUrl: product['image']!,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Nearby Farms',
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            'Within 5mi',
                            style: textTheme.bodySmall?.copyWith(
                              color: AppColors.textMuted,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Column(
                      children: farms.map((farm) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: MilkFarmCard(
                            name: farm['name']! as String,
                            distance: farm['distance']! as String,
                            description: farm['description']! as String,
                            rating: farm['rating']! as double,
                            reviews: farm['reviews']! as int,
                            imageUrl: farm['image']! as String,
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20 * scale),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
