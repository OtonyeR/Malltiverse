import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';
import '../services/api_services.dart';

class ProductRatingNotifier extends StateNotifier<String> {
  ProductRatingNotifier() : super('0');

  Future<void> fetchRating(productId) async {
    try {
      final rating = await ApiService().getInfo(productId);
      state = rating;
    } catch (e) {
      state = '0';
    }
  }
}

// Define a state notifier to manage the product list state
class ProductNotifier extends StateNotifier<List<Product>> {
  ProductNotifier() : super([]);

  Future<void> fetchProducts() async {
    try {
      final products = await ApiService().getProducts();
      final productList =
          products.map((item) => Product.fromJson(item)).toList();
      state = productList;
    } catch (e) {
      state = [];
    }
  }
}

// state notifier provider
final productProvider =
    StateNotifierProvider<ProductNotifier, List<Product>>((ref) {
  return ProductNotifier();
});

// provider for ProductRatingNotifier
final productRatingProvider =
    StateNotifierProvider<ProductRatingNotifier, String>((ref) {
  return ProductRatingNotifier();
});

final loadingStateProvider = StateProvider<bool>((ref) => true);
