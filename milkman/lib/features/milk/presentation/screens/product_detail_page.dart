import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:milkman/core/widgets/network_image_with_fallback.dart';
import 'package:milkman/features/milk/presentation/cubit/cart_cubit.dart';
import 'package:milkman/features/milk/presentation/models/cart_item.dart';

class ProductDetailPage extends StatefulWidget {
  final String id;
  final String name;
  final String subtitle;
  final double price; // PKR
  final String imageUrl;

  const ProductDetailPage({
    super.key,
    required this.id,
    required this.name,
    required this.subtitle,
    required this.price,
    required this.imageUrl,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  String plan = 'one-time';
  String frequency = 'daily';
  int liters = 1;
  final Map<String, bool> extras = {
    'Yogurt': false,
    'Butter': false,
    'Cheese': false,
    'Jam': false,
    'Lassi': false,
    'Eggs': false,
    'Bread': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 220,
              child: NetworkImageWithFallback(
                imageUrl: widget.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),
            Text(widget.name, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 6),
            Text(
              widget.subtitle,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            Text(
              'Price: PKR ${widget.price.toStringAsFixed(0)}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),

            // Plan selector
            DropdownButtonFormField<String>(
              value: plan,
              items: const [
                DropdownMenuItem(value: 'one-time', child: Text('One-time')),
                DropdownMenuItem(value: 'weekly', child: Text('Weekly')),
                DropdownMenuItem(value: 'monthly', child: Text('Monthly')),
              ],
              onChanged: (v) => setState(() => plan = v ?? 'one-time'),
              decoration: const InputDecoration(labelText: 'Plan'),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('Liters:'),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () => setState(() => liters = 30),
                  child: const Text('30L'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => setState(() => liters = 50),
                  child: const Text('50L'),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 80,
                  child: TextFormField(
                    initialValue: liters.toString(),
                    keyboardType: TextInputType.number,
                    onChanged: (v) =>
                        setState(() => liters = int.tryParse(v) ?? liters),
                    decoration: const InputDecoration(labelText: 'Custom'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text('Add daily extras'),
            const SizedBox(height: 6),
            Wrap(
              spacing: 8,
              children: extras.keys.map((e) {
                return FilterChip(
                  label: Text(e),
                  selected: extras[e]!,
                  onSelected: (s) => setState(() => extras[e] = s),
                );
              }).toList(),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                final item = CartItem(
                  id: widget.id,
                  name: widget.name,
                  subtitle: widget.subtitle,
                  price: widget.price * liters,
                  quantity: 1,
                  options: {
                    'plan': plan,
                    'liters': liters,
                    'extras': extras.entries
                        .where((e) => e.value)
                        .map((e) => e.key)
                        .toList(),
                  },
                );
                context.read<CartCubit>().addItem(item);
                Navigator.pop(context);
              },
              child: const Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
