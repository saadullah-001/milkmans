class CartItem {
  final String id;
  final String name;
  final String subtitle;
  final double price;
  int quantity;
  final Map<String, dynamic> options;

  CartItem({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.price,
    this.quantity = 1,
    this.options = const {},
  });

  double get subtotal => price * quantity;
}
