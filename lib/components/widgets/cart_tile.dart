import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:malltiverse/components/colors.dart';
import 'package:malltiverse/components/widgets/price_tag.dart';

import '../../models/product.dart';
import '../../providers/cart_provider.dart';
import '../../providers/wishlist_provider.dart';

class CartTile extends ConsumerStatefulWidget {
  final Product cartItem;
  // final String itemCount;
  final VoidCallback onRemoveItem;
  final VoidCallback onReduceQuantity;
  final VoidCallback onIncreaseQuantity;
  const CartTile({
    required this.cartItem,
    super.key,
    required this.onRemoveItem,
    required this.onReduceQuantity,
    required this.onIncreaseQuantity,
  });

  @override
  ConsumerState<CartTile> createState() => _CartTileState();
}

class _CartTileState extends ConsumerState<CartTile> {
  @override
  Widget build(BuildContext context) {
    final wishNotifier = ref.read(wishlistProvider.notifier);
    final cartNotifier = ref.read(cartProvider.notifier);
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.16,
          margin: const EdgeInsets.only(bottom: 18),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 28),
          decoration: BoxDecoration(
            border: Border.all(color: const Color.fromRGBO(42, 42, 42, 0.1)),
          ),
          child: Row(
            children: [
              Container(
                height: 78,
                width: 60,
                color: const Color.fromRGBO(237, 237, 237, 0.67),
                child: Image.network(
                  widget.cartItem.imageUrl,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      direction: Axis.vertical,
                      spacing: 3,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            widget.cartItem.name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: mainBlack,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            widget.cartItem.description,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 11,
                              color: mainBlack,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 13),
                    SizedBox(
                        width: 88,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              // padding: const EdgeInsets.symmetric(
                              //     horizontal: 15, vertical: 28),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromRGBO(42, 42, 42, 1)),
                              ),
                              child: InkWell(
                                onTap: widget.onReduceQuantity,
                                child: const Icon(
                                  Icons.remove,
                                  weight: 2,
                                  size: 17,
                                ),
                              ),
                            ),
                            Text(
                              widget.cartItem.quantity.toString(),
                              style: const TextStyle(fontSize: 12),
                            ),
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromRGBO(42, 42, 42, 1)),
                              ),
                              child: Center(
                                child: InkWell(
                                  onTap: widget.onIncreaseQuantity,
                                  child: const Center(
                                    child: Icon(
                                      Icons.add,
                                      weight: 2,
                                      size: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 18,
                    width: 18,
                    child: GestureDetector(
                        onTap: widget.onRemoveItem,
                        child: Image.asset('assets/Vuesax.png')),
                  ),
                  Text(
                    priceTextTh((widget.cartItem.currentPrice *
                            widget.cartItem.quantity)
                        .toString()),
                    style: const TextStyle(
                      color: mainBlack,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ))
            ],
          ),
        ),
        Positioned(
            top: 12,
            child: IconButton(
              onPressed: () {
                cartNotifier.removeFromCart(widget.cartItem);
                wishNotifier.addProduct(widget.cartItem);
              },
              icon: const CircleAvatar(
                radius: 14,
                backgroundColor: primaryColor,
                child: Icon(
                  Icons.favorite_border_rounded,
                  color: mainWhite,
                  size: 18,
                ),
              ),
            ))
      ],
    );
  }
}
