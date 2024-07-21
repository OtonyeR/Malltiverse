import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:malltiverse/models/order_item.dart';
import 'package:malltiverse/services/hive_services.dart';

class OrderHistoryNotifier extends StateNotifier<List<OrderItem>> {
  OrderHistoryNotifier() : super([]) {
    _loadHistoryProvider();
  }

  final OrderHistoryBox _historyBox = OrderHistoryBox();

  Future<void> _loadHistoryProvider() async {
    state = _historyBox.getOrderHistory();
  }

  void addOrder(OrderItem order) {
    _historyBox.addOrder(order);
    state = _historyBox.getOrderHistory();
  }

  List<OrderItem> get orders => state;
}

final orderHistoryProvider =
    StateNotifierProvider<OrderHistoryNotifier, List<OrderItem>>(
  (ref) => OrderHistoryNotifier(),
);
