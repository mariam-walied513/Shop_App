import 'product.dart';

enum OrderStatus { active, completed, cancelled }

class Order {
  final List<Product> items;   // ✏️ List بدل Product واحد
  final DateTime date;
  OrderStatus status;

  Order({
    required this.items,
    required this.date,
    this.status = OrderStatus.active,
  });

  // عدد المنتجات
  int get itemsCount => items.length;

  // أول منتج (للكارت)
  Product get firstProduct => items.first;

  // ✅ السعر الإجمالي (بيحسب من المنتجات)
  double get subtotal {
    double sum = 0;
    for (var item in items) {
      sum += _parsePrice(item.price);
    }
    return sum;
  }

  // ✅ الضريبة (5%)
  double get tax => subtotal * 0.05;

  // ✅ رسوم التوصيل (ثابتة $2)
  double get deliveryFee => 2.0;

  // ✅ الإجمالي
  double get total => subtotal + tax + deliveryFee;

  // ✅ helper: يحوّل "$ 34.00" لـ 34.0
  double _parsePrice(String price) {
    final cleaned = price.replaceAll(RegExp(r'[^\d.]'), '');
    return double.tryParse(cleaned) ?? 0;
  }

  // ✅ helper: format السعر
  String formatPrice(double value) {
    return '\$ ${value.toStringAsFixed(2)}';
  }
}