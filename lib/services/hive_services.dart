import 'package:hive_flutter/hive_flutter.dart';
import 'package:malltiverse/models/order_item.dart';
import '../models/product.dart';

class WishBox {
  // Access the already opened box
  Box<Product> get _hive => Hive.box<Product>('dataBox');

  List<Product> getWishItems() {
    return _hive.values.toList();
  }

  List<Product> addProduct(Product product) {
    _hive.add(product);
    return _hive.values.toList();
  }

  List<Product> removeProduct(String id) {
    final index =
        _hive.values.toList().indexWhere((element) => element.id == id);
    if (index != -1) {
      _hive.deleteAt(index);
    }
    return _hive.values.toList();
  }

  List<Product> updateProduct(Product product) {
    final index =
        _hive.values.toList().indexWhere((element) => element.id == product.id);
    if (index != -1) {
      _hive.putAt(index, product);
    }
    return _hive.values.toList();
  }

  void deleteAll() {
    _hive.clear();
  }
}

class OrderHistoryBox {
  // Access the already opened box
  Box<OrderItem> get _hive => Hive.box<OrderItem>('historyBox');

  List<OrderItem> getOrderHistory() {
    return _hive.values.toList();
  }

  void addOrder(OrderItem order) {
    _hive.add(order);
  }

  void clearHistory() {
    _hive.clear();
  }
}
