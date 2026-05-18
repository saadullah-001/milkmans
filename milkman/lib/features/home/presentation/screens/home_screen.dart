import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:milkman/core/theme/app_colors.dart';
import 'package:milkman/features/auth/presentation/cubits/session_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: BlocBuilder<SessionCubit, SessionState>(
                      builder: (context, state) {
                        final userName =
                            state.user?.displayName ?? 'Alex Johnson';
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Good Morning,',
                              style: textTheme.bodyMedium?.copyWith(
                                color: AppColors.textMuted,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              userName,
                              style: textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.text,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  size: 18,
                                  color: AppColors.organic,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Green Valley, NY',
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Container(
                    height: 44,
                    width: 44,
                    decoration: BoxDecoration(
                      color: AppColors.organic.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.notifications_none,
                      color: AppColors.organic,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildHeroCard(theme, textTheme),
                    const SizedBox(height: 24),
                    _buildSectionHeader(
                      title: 'Fresh Categories',
                      action: 'View All',
                      onTap: () {},
                      textTheme: textTheme,
                    ),
                    const SizedBox(height: 16),
                    _buildCategoryGrid(textTheme),
                    const SizedBox(height: 28),
                    _buildSectionHeader(
                      title: 'Subscription Plans',
                      action: 'See Plans',
                      onTap: () {},
                      textTheme: textTheme,
                    ),
                    const SizedBox(height: 16),
                    _buildSubscriptionRow(textTheme),
                    const SizedBox(height: 28),
                    _buildSectionHeader(
                      title: 'Popular Right Now',
                      action: 'Explore',
                      onTap: () {},
                      textTheme: textTheme,
                    ),
                    const SizedBox(height: 16),
                    _buildPopularRow(textTheme),
                    const SizedBox(height: 28),
                    Text(
                      'Nearby Farms',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 14),
                    _buildFarmCard(
                      title: 'Sunny Pastures',
                      subtitle: 'Specializes in grass-fed cow milk and dairy',
                      distance: '2.3 mi',
                      rating: '4.8',
                      context: context,
                    ),
                    const SizedBox(height: 12),
                    _buildFarmCard(
                      title: 'River Organics',
                      subtitle: 'Certified organic goat milk and fresh cheese',
                      distance: '4.1 mi',
                      rating: '4.9',
                      context: context,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _HomeBottomNavigationBar(),
    );
  }

  Widget _buildHeroCard(ThemeData theme, TextTheme textTheme) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'Limited Offer',
                    style: textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  'Urgent Delivery Today',
                  style: textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Fresh morning milk before 10 AM.',
                  style: textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 18),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.primaryDark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 14,
                    ),
                  ),
                  child: const Text('Order Now'),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            height: 140,
            width: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              image: const DecorationImage(
                image: AssetImage('assets/images/milk.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required String action,
    required VoidCallback onTap,
    required TextTheme textTheme,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.text,
          ),
        ),
        TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
            padding: EdgeInsets.zero,
          ),
          child: Text(
            action,
            style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryGrid(TextTheme textTheme) {
    final categories = [
      _CategoryData(
        title: 'Cow Milk',
        subtitle: 'Organic & Fresh',
        price: '\$5.50/L',
        backgroundColor: AppColors.surface,
      ),
      _CategoryData(
        title: 'Buffalo Milk',
        subtitle: 'Rich & Creamy',
        price: '\$5.20/L',
        backgroundColor: AppColors.surface,
      ),
      _CategoryData(
        title: 'Farm Cheese',
        subtitle: 'Aged Cheddar',
        price: '\$8.50/200g',
        backgroundColor: AppColors.surface,
      ),
      _CategoryData(
        title: 'Greek Yogurt',
        subtitle: 'Probiotic Rich',
        price: '\$3.90/cup',
        backgroundColor: AppColors.surface,
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.95,
      ),
      itemBuilder: (context, index) {
        final item = categories[index];
        return _CategoryCard(data: item, textTheme: textTheme);
      },
    );
  }

  Widget _buildSubscriptionRow(TextTheme textTheme) {
    final plans = [
      _SubscriptionData(
        title: 'Morning Essentials',
        description: 'Milk, Eggs & Bread daily by 7 AM.',
        price: '\$99/mo',
        tag: 'Daily Morning',
        color: AppColors.primaryLight,
      ),
      _SubscriptionData(
        title: 'Family Pack',
        description: 'Premium dairy bundle for 4 people.',
        price: '\$160/mo',
        tag: 'Weekly Plan',
        color: AppColors.organic.withOpacity(0.12),
      ),
    ];

    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: plans.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final plan = plans[index];
          return _SubscriptionCard(data: plan, textTheme: textTheme);
        },
      ),
    );
  }

  Widget _buildPopularRow(TextTheme textTheme) {
    final items = [
      _ProductData(
        title: 'Pure Goat Milk',
        subtitle: '1 Liter Bottle',
        price: '\$6.00',
      ),
      _ProductData(
        title: 'Salted Butter',
        subtitle: '200g Pack',
        price: '\$3.50',
      ),
      _ProductData(title: 'Organic Eggs', subtitle: '12-Pack', price: '\$8.90'),
    ];

    return SizedBox(
      height: 156,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          return _PopularItemCard(data: items[index], textTheme: textTheme);
        },
      ),
    );
  }

  Widget _buildFarmCard({
    required String title,
    required String subtitle,
    required String distance,
    required String rating,
    required BuildContext context,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.outline),
      ),
      child: Row(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: AppColors.organic.withOpacity(0.12),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.park_outlined,
              color: AppColors.organic,
              size: 32,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                distance,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, size: 14, color: AppColors.warning),
                    const SizedBox(width: 4),
                    Text(
                      rating,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CategoryData {
  final String title;
  final String subtitle;
  final String price;
  final Color backgroundColor;

  _CategoryData({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.backgroundColor,
  });
}

class _CategoryCard extends StatelessWidget {
  final _CategoryData data;
  final TextTheme textTheme;

  const _CategoryCard({required this.data, required this.textTheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: data.backgroundColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.local_drink_outlined,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            data.title,
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            data.subtitle,
            style: textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data.price,
                style: textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  color: AppColors.organic,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SubscriptionData {
  final String title;
  final String description;
  final String price;
  final String tag;
  final Color color;

  _SubscriptionData({
    required this.title,
    required this.description,
    required this.price,
    required this.tag,
    required this.color,
  });
}

class _SubscriptionCard extends StatelessWidget {
  final _SubscriptionData data;
  final TextTheme textTheme;

  const _SubscriptionCard({required this.data, required this.textTheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: data.color,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              data.tag,
              style: textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.text,
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            data.title,
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            data.description,
            style: textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
          ),
          const Spacer(),
          Text(
            data.price,
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            ),
            child: const Text('Subscribe'),
          ),
        ],
      ),
    );
  }
}

class _ProductData {
  final String title;
  final String subtitle;
  final String price;

  _ProductData({
    required this.title,
    required this.subtitle,
    required this.price,
  });
}

class _PopularItemCard extends StatelessWidget {
  final _ProductData data;
  final TextTheme textTheme;

  const _PopularItemCard({required this.data, required this.textTheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Icon(
                  Icons.local_drink_outlined,
                  color: AppColors.primary,
                  size: 32,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            data.title,
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            data.subtitle,
            style: textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
          ),
          const SizedBox(height: 12),
          Text(
            data.price,
            style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _HomeBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textMuted,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt_long_outlined),
          label: 'Orders',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.qr_code_scanner),
          label: 'Scan',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet_outlined),
          label: 'Wallet',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
    );
  }
}
