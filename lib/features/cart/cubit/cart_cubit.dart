import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/product.dart';

class CartCubit extends Cubit<List<CartItem>> {
  CartCubit() : super([]);

  void addToCart(Product product, {int quantity = 1}) {
    final items = List<CartItem>.from(state);

    // ✅ لو المنتج موجود، زوّد الكمية
    final index = items.indexWhere((i) => i.product.id == product.id);
    if (index != -1) {
      items[index] = items[index].copyWith(
        quantity: items[index].quantity + quantity,
      );
    } else {
      items.add(CartItem(product: product, quantity: quantity));
    }

    emit(items);
  }

  void removeFromCart(Product product) {
    final items = state.where((i) => i.product.id != product.id).toList();
    emit(items);
  }

  void clearCart() {
    emit([]);
  }

  // ✅ الإجمالي
  double get total {
    double sum = 0;
    for (var item in state) {
      final priceStr = item.product.price.replaceAll(RegExp(r'[^\d.]'), '');
      final price = double.tryParse(priceStr) ?? 0;
      sum += price * item.quantity;
    }
    return sum;
  }
}

class CartItem {
  final Product product;
  final int quantity;

  CartItem({required this.product, required this.quantity});

  CartItem copyWith({int? quantity}) {
    return CartItem(
      product: product,
      quantity: quantity ?? this.quantity,
    );
  }
}