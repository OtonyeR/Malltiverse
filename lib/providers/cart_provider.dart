import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';

class Cart extends StateNotifier<List<Product>> {
  Cart() : super([]);

  int get deliveryFee => 1500;

  List<Product> get cartItems => state;

  void addToCart(Product item) {
    state = [
      for (final product in state)
        if (product.name == item.name)
          Product(
            name: product.name,
            currentPrice: product.currentPrice,
            quantity: product.quantity + 1,
            id: product.id,
            category: product.category,
            imageUrl: product.imageUrl,
            description: product.description,
          )
        else
          product,
      if (state.where((product) => product.name == item.name).isEmpty)
        Product(
          name: item.name,
          currentPrice: item.currentPrice,
          quantity: item.quantity + 1,
          id: item.id,
          category: item.category,
          imageUrl: item.imageUrl,
          description: item.description,
        )
    ];
  }

  void removeFromCart(Product item) {
    state = state.where((product) => product.name != item.name).toList();
  }

  void reduceQuantity(Product item) {
    state = [
      for (final product in state)
        if (product.id == item.id && product.quantity > 1)
          Product(
            id: product.id,
            name: product.name,
            currentPrice: product.currentPrice,
            quantity: product.quantity - 1,
            category: product.category,
            imageUrl: product.imageUrl,
            description: product.description,
          )
        else
          product
    ];
  }

  String calcTotalQuantity() {
    int totalQuantity = state.fold(0, (sum, product) => sum + product.quantity);
    return totalQuantity.toString();
  }

  String calcSubTotal() {
    int totalPrice = 0;
    for (var product in state) {
      totalPrice += product.currentPrice * product.quantity;
    }
    return totalPrice.toString();
  }

  String calcTotal() {
    int totalPrice = deliveryFee;
    for (var product in state) {
      totalPrice += product.currentPrice * product.quantity;
    }
    return totalPrice.toString();
  }
}

final cartProvider = StateNotifierProvider<Cart, List<Product>>((ref) {
  return Cart();
});
