import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:milkman/features/milk/presentation/cubit/cart_cubit.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  if (state.items.isEmpty)
                    return const Center(child: Text('Cart is empty'));
                  return ListView.separated(
                    itemCount: state.items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final item = state.items[index];
                      return Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item.subtitle,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'PKR ${item.price.toStringAsFixed(0)}',
                                  style: Theme.of(context).textTheme.titleSmall
                                      ?.copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                      ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () => context
                                          .read<CartCubit>()
                                          .updateQuantity(
                                            item,
                                            (item.quantity - 1).clamp(1, 999),
                                          ),
                                      icon: const Icon(
                                        Icons.remove_circle_outline,
                                      ),
                                    ),
                                    Text(item.quantity.toString()),
                                    IconButton(
                                      onPressed: () => context
                                          .read<CartCubit>()
                                          .updateQuantity(
                                            item,
                                            item.quantity + 1,
                                          ),
                                      icon: const Icon(
                                        Icons.add_circle_outline,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () =>
                                context.read<CartCubit>().removeItem(item),
                            icon: const Icon(Icons.delete_outline),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 12),
            // Delivery details
            _DeliveryForm(),

            const SizedBox(height: 12),
            BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Total: PKR ${state.total.toStringAsFixed(0)}',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed:
                          state.items.isEmpty || state.deliveryAddress == null
                          ? null
                          : () async {
                              final success = await context
                                  .read<CartCubit>()
                                  .checkout();
                              if (success) {
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: const Text('Order Placed'),
                                    content: const Text(
                                      'Your order has been placed successfully.',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                      child: const Text('Place Order'),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DeliveryForm extends StatefulWidget {
  @override
  State<_DeliveryForm> createState() => _DeliveryFormState();
}

class _DeliveryFormState extends State<_DeliveryForm> {
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _address = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Column(
          children: [
            TextFormField(
              controller: _name,
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _phone,
              decoration: const InputDecoration(labelText: 'Phone'),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _address,
              decoration: const InputDecoration(labelText: 'Delivery Address'),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Cash on Delivery'),
                    value: 'cod',
                    groupValue: state.paymentMethod,
                    onChanged: (v) =>
                        context.read<CartCubit>().setPaymentMethod(v!),
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Card'),
                    value: 'card',
                    groupValue: state.paymentMethod,
                    onChanged: (v) =>
                        context.read<CartCubit>().setPaymentMethod(v!),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                context.read<CartCubit>().setDeliveryDetails(
                  name: _name.text,
                  phone: _phone.text,
                  address: _address.text,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Delivery details saved')),
                );
              },
              child: const Text('Save Delivery Details'),
            ),
          ],
        );
      },
    );
  }
}
