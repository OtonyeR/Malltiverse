import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';
import '../services/hive_services.dart';

class WishlistNotifier extends StateNotifier<List<Product>> {
  WishlistNotifier() : super([]) {
    _loadWishList();
  }

  final WishBox _wishBox = WishBox();

  Future<void> _loadWishList() async {
    state = _wishBox.getWishItems();
  }

  void addProduct(Product product) {
    _wishBox.addProduct(product);
    state = _wishBox.getWishItems();
  }

  void removeProduct(String productId) {
    _wishBox.removeProduct(productId);
    state = _wishBox.getWishItems();
  }

  bool isWished(String productId) {
    return state.any((product) => product.id == productId);
  }
}

final wishlistProvider = StateNotifierProvider<WishlistNotifier, List<Product>>(
  (ref) => WishlistNotifier(),
);
