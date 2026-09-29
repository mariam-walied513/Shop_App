import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/order.dart';
import '../models/product.dart';
import 'orders_state.dart';
import '../services/api_service.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial());

  final List<Order> _orders = [];
  final ApiService _api = ApiService();

  List<Order> get allOrders => _orders;

  void _emitLoaded() {
    emit(
      OrdersLoaded(
        activeOrders:
            _orders.where((o) => o.status == OrderStatus.active).toList(),
        completedOrders:
            _orders.where((o) => o.status == OrderStatus.completed).toList(),
        cancelledOrders:
            _orders.where((o) => o.status == OrderStatus.cancelled).toList(),
      ),
    );
  }

  void addOrder(List<Product> items) {
    _orders.add(Order(items: items, date: DateTime.now()));
    _emitLoaded();
  }

  void addOrderFirst(List<Product> items) {
    _orders.insert(
      0,
      Order(items: items, date: DateTime(2005, 5, 15, 13, 30)),
    );
    _emitLoaded();
  }

  void cancelOrder(Order order) {
    order.status = OrderStatus.cancelled;
    _emitLoaded();
  }

  void completeOrder(Order order) {
    order.status = OrderStatus.completed;
    _emitLoaded();
  }

  void removeOrder(Order order) {
    _orders.remove(order);
    _emitLoaded();
  }

  Future<Map<String, dynamic>?> placeOrder(
    List<Map<String, int>> items,
  ) async {
    return await _api.placeOrder(items);
  }
}