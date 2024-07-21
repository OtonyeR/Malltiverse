import 'package:flutter/material.dart';
import 'package:malltiverse/components/colors.dart';
import 'package:malltiverse/components/widgets/price_tag.dart';
import 'package:malltiverse/models/product.dart';

class WishTile extends StatefulWidget {
  final Product cartItem;
  final VoidCallback onRemoveItem;
  final VoidCallback onMoveToCart;

  const WishTile({
    required this.cartItem,
    super.key,
    required this.onRemoveItem,
    required this.onMoveToCart,
  });

  @override
  State<WishTile> createState() => _WishTileState();
}

class _WishTileState extends State<WishTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 28),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(42, 42, 42, 0.1)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    const SizedBox(height: 15),
                    Text(
                      priceTextTh((widget.cartItem.currentPrice).toString()),
                      style: const TextStyle(
                        color: mainBlack,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                  height: 78,
                  width: 60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 18,
                        width: 18,
                        child: GestureDetector(
                            onTap: widget.onRemoveItem,
                            child: Image.asset(
                              'assets/Vuesax.png',
                              scale: 0.1,
                            )),
                      ),
                    ],
                  ))
            ],
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: widget.onMoveToCart,
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12)),
              child: const Text(
                'Move to Cart',
                style: TextStyle(
                  fontSize: 14,
                  color: mainWhite,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
