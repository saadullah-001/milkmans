import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:milkman/features/milk/presentation/cubit/cart_cubit.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final String location;
  final VoidCallback onCartTap;

  const CustomAppBar({
    super.key,
    required this.userName,
    required this.location,
    required this.onCartTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // User Greeting Text Block
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good Morning,',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blueGrey[400],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  //const SizedBox(height: 4),
                  Text(
                    userName,
                    style: const TextStyle(
                      fontSize: 22,
                      color: Color(0xFF1E293B), // Dark slate/navy
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Location Tag
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(
                  0xFFE0F2FE,
                ), // Very light teal/blue background
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 16,
                    color: Color(0xFF0F766E), // Teal accent color
                  ),
                  const SizedBox(width: 4),
                  Text(
                    location,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF0F766E),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),

            Material(
              color: Colors.white,
              shape: const CircleBorder(),
              elevation: 4,
              shadowColor: Colors.black.withValues(alpha: 0.08),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: onCartTap,
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Semantics(
                    button: true,
                    label: 'Open cart',
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const Icon(
                          Icons.shopping_cart_outlined,
                          color: Color(0xFF1E293B),
                          size: 22,
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: BlocSelector<CartCubit, CartState, int>(
                            selector: (state) => state.itemCount,
                            builder: (context, itemCount) {
                              if (itemCount == 0) {
                                return const SizedBox.shrink();
                              }
                              return Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 18,
                                  minHeight: 18,
                                ),
                                child: Text(
                                  itemCount.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80.0);
}
