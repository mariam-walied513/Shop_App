import '../models/order.dart';

abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class OrdersLoaded extends OrdersState {
  final List<Order> activeOrders;
  final List<Order> completedOrders;
  final List<Order> cancelledOrders;

  OrdersLoaded({
    required this.activeOrders,
    required this.completedOrders,
    required this.cancelledOrders,
  });
}