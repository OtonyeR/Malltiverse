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
    state = [...state, order];
  }

  List<OrderItem> get orders => state;
}

final orderHistoryProvider =
    StateNotifierProvider<OrderHistoryNotifier, List<OrderItem>>(
  (ref) => OrderHistoryNotifier(),
);
