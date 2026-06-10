import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/cart_item.dart';

class CartState {
  final List<CartItem> items;
  final String? deliveryName;
  final String? deliveryPhone;
  final String? deliveryAddress;
  final String paymentMethod; // 'cod' or 'card'
  final bool checkingOut;

  CartState({
    this.items = const [],
    this.deliveryName,
    this.deliveryPhone,
    this.deliveryAddress,
    this.paymentMethod = 'cod',
    this.checkingOut = false,
  });

  double get total => items.fold(0, (p, e) => p + e.subtotal);

  int get itemCount => items.fold(0, (count, item) => count + item.quantity);

  CartState copyWith({
    List<CartItem>? items,
    String? deliveryName,
    String? deliveryPhone,
    String? deliveryAddress,
    String? paymentMethod,
    bool? checkingOut,
  }) {
    return CartState(
      items: items ?? this.items,
      deliveryName: deliveryName ?? this.deliveryName,
      deliveryPhone: deliveryPhone ?? this.deliveryPhone,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      checkingOut: checkingOut ?? this.checkingOut,
    );
  }
}

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState());

  void addItem(CartItem item) {
    final existing = state.items
        .where((e) => e.id == item.id && _mapEquals(e.options, item.options))
        .toList();
    if (existing.isNotEmpty) {
      existing.first.quantity += item.quantity;
      emit(state.copyWith(items: List.from(state.items)));
      return;
    }
    emit(state.copyWith(items: List.from(state.items)..add(item)));
  }

  void removeItem(CartItem item) {
    emit(state.copyWith(items: List.from(state.items)..remove(item)));
  }

  void updateQuantity(CartItem item, int qty) {
    final idx = state.items.indexOf(item);
    if (idx == -1) return;
    state.items[idx].quantity = qty;
    emit(state.copyWith(items: List.from(state.items)));
  }

  void setDeliveryDetails({String? name, String? phone, String? address}) {
    emit(
      state.copyWith(
        deliveryName: name ?? state.deliveryName,
        deliveryPhone: phone ?? state.deliveryPhone,
        deliveryAddress: address ?? state.deliveryAddress,
      ),
    );
  }

  void setPaymentMethod(String method) {
    emit(state.copyWith(paymentMethod: method));
  }

  Future<bool> checkout() async {
    emit(state.copyWith(checkingOut: true));
    await Future.delayed(const Duration(seconds: 2));
    // For demo, we just clear cart and return success
    emit(CartState());
    return true;
  }

  bool _mapEquals(Map a, Map b) {
    if (a.length != b.length) return false;
    for (final k in a.keys) {
      if (!b.containsKey(k) || b[k] != a[k]) return false;
    }
    return true;
  }
}
