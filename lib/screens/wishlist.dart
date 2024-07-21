import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../components/colors.dart';
import '../components/widgets/empty_view.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../providers/wishlist_provider.dart';
import '../components/widgets/wish_tile.dart';

class WishListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishItems = ref.watch(wishlistProvider);
    final wishNotifier = ref.read(wishlistProvider.notifier);
    final cartNotifier = ref.read(cartProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: mainWhite,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: mainBlack,
          ),
        ),
        title: const Text(
          'Wishlist',
          style: TextStyle(color: mainBlack),
        ),
      ),
      body: Column(
        children: [
          wishItems.isEmpty
              ? EmptyListView()
              : Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: wishItems.length,
                    itemBuilder: (context, index) {
                      final product = wishItems[index];
                      return WishTile(
                        onRemoveItem: () {
                          ref
                              .read(wishlistProvider.notifier)
                              .removeProduct(product.id);
                        },
                        onMoveToCart: () {
                          cartNotifier.addToCart(product);
                          wishNotifier.removeProduct(product.id);
                        },
                        cartItem: product,
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
