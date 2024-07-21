import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:malltiverse/components/widgets/price_tag.dart';
import 'package:malltiverse/components/widgets/star_rating.dart';
import '../../models/product.dart';
import '../../providers/wishlist_provider.dart';
import '../colors.dart';

class ProductTile extends ConsumerWidget {
  final Product product;
  final String productRating;
  final VoidCallback onAddToCart;

  ProductTile({
    Key? key,
    required this.productRating,
    required this.product,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isWished = ref.watch(wishlistProvider).any((p) => p.id == product.id);

    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.42990,
        margin: const EdgeInsets.only(right: 13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.1978,
                  width: MediaQuery.of(context).size.width * 0.44,
                  color: grey,
                ),
                Positioned.fill(
                  child: Image.network(
                    product.imageUrl,
                    alignment: Alignment.center,
                    scale: 1.2,
                  ),
                ),
                Positioned(
                  bottom: 2,
                  right: 0,
                  child: IconButton(
                    onPressed: () {
                      final wishlistNotifier =
                          ref.read(wishlistProvider.notifier);
                      if (isWished) {
                        wishlistNotifier.removeProduct(product.id);
                      } else {
                        wishlistNotifier.addProduct(product);
                      }
                    },
                    icon: CircleAvatar(
                      radius: 15,
                      backgroundColor: primaryColor,
                      child: Icon(
                        isWished
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color: mainWhite,
                        size: 18,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.44,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: mainBlack),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: mainBlack),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            buildStarRating(productRating),
            const SizedBox(height: 13),
            Text(
              priceTextTh(product.currentPrice.toString()),
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: primaryColor),
            ),
            const SizedBox(height: 17),
            ElevatedButton(
              onPressed: onAddToCart,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: mainWhite,
                onPrimary: primaryColor,
                side: const BorderSide(color: primaryColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                'Add to Cart',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: mainBlack),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
