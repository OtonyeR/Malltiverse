import 'package:flutter/material.dart';
import 'package:malltiverse/components/colors.dart';
import 'package:malltiverse/components/widgets/cart_tile.dart';
import 'package:malltiverse/components/widgets/custom_divider.dart';

import 'package:malltiverse/navigation_menu.dart';
import 'package:malltiverse/screens/checkout_screen.dart';

import '../models/cart.dart';

class CartScreen extends StatefulWidget {
  final Cart cart;
  const CartScreen({Key? key, required this.cart}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      cart: widget.cart,
      title: 'My cart',
      showLogo: true,
      child: Padding(
        padding: const EdgeInsets.all(21),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: widget.cart.cartItems.isEmpty
              ? Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.35),
                  alignment: Alignment.center,
                  child: Text(
                    'No Item in Cart',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                )
              : Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: widget.cart.cartItems.length,
                          itemBuilder: (context, index) {
                            return CartTile(
                              cartItem: widget.cart.cartItems[index],
                              onRemoveItem: () {
                                setState(() {
                                  widget.cart.removeFromCart(
                                      widget.cart.cartItems[index]);
                                });
                              },
                              onReduceQuantity: () {
                                setState(() {
                                  widget.cart.cartItems[index].quantity--;
                                });
                              },
                              onIncreaseQuantity: () {
                                setState(() {
                                  widget.cart.cartItems[index].quantity++;
                                });
                              },
                            );
                          }),
                    ),
                    const SizedBox(height: 31),
                    Container(
                      alignment: Alignment.bottomCenter,
                      margin: const EdgeInsets.only(bottom: 31),
                      padding: const EdgeInsets.only(
                          left: 17, top: 20, right: 15, bottom: 18),
                      decoration: BoxDecoration(
                          color: grey,
                          borderRadius: BorderRadius.circular(4.0)),
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Shopping Summary',
                              style: TextStyle(
                                fontSize: 16,
                                color: mainBlack,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Discount Code',
                              style: TextStyle(
                                fontSize: 14,
                                color: mainBlack.withOpacity(0.64),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 43,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(9),
                                          borderSide: BorderSide(
                                              color:
                                                  mainBlack.withOpacity(0.7))),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  width:
                                      16), // Space between text field and button
                              ElevatedButton(
                                onPressed: () {
                                  // Show a SnackBar
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Discount Added'),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 16)),
                                child: const Text(
                                  'Apply',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: mainBlack,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Sub-Total',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: mainBlack.withOpacity(0.7),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    'N ${widget.cart.calcSubTotal().toString()}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: mainBlack,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 17),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Delivery Fee',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: mainBlack.withOpacity(0.7),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    'N ${widget.cart.deliveryFee}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: mainBlack,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 17),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Discount Amount',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: mainBlack.withOpacity(0.7),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Text(
                                    'N 0',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: mainBlack,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 25),
                          DottedLineDivider(),
                          const SizedBox(height: 22),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: mainBlack.withOpacity(0.7),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                'N ${widget.cart.calcTotal()}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: mainBlack,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 35),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CheckOutScreen(
                                            cart: widget.cart,
                                          )),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15)),
                              child: const Text(
                                'Checkout',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: mainBlack,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
