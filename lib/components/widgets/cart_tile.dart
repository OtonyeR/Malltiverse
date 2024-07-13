import 'package:flutter/material.dart';
import 'package:malltiverse/components/colors.dart';

import '../../models/cart.dart';
import '../../models/product.dart';

class CartTile extends StatefulWidget {
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
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.16,
      margin: EdgeInsets.only(bottom: 18),
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
            child: Image.asset(
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
                    Text(
                      widget.cartItem.name,
                      style: const TextStyle(
                        fontSize: 12,
                        color: mainBlack,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      widget.cartItem.description,
                      style: const TextStyle(
                        fontSize: 11,
                        color: mainBlack,
                        fontWeight: FontWeight.w400,
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
                          child: GestureDetector(
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
                          style: TextStyle(fontSize: 12),
                        ),
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromRGBO(42, 42, 42, 1)),
                          ),
                          child: Center(
                            child: GestureDetector(
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
                'N ${(widget.cartItem.currentPrice * widget.cartItem.quantity).toString()}',
                style: const TextStyle(
                  color: mainBlack,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
