import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:malltiverse/components/colors.dart';
import 'package:malltiverse/components/widgets/cart_tile.dart';
import 'package:malltiverse/components/widgets/custom_divider.dart';
import 'package:malltiverse/components/widgets/price_tag.dart';
import 'package:malltiverse/screens/nav_screen.dart';
import '../components/widgets/empty_view.dart';
import '../providers/cart_provider.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);
    TextEditingController discountCode = TextEditingController();

    return Scaffold(
      backgroundColor: mainWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: mainWhite,
        leading: Container(
            margin: const EdgeInsets.only(left: 24),
            child: Image.asset('assets/Malltiverse Logo.png')),
        leadingWidth: 105,
        title: const Text(
          'Product List',
          style: TextStyle(color: mainBlack),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: cartItems.isEmpty
                ? const EmptyListView()
                : Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.36,
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: cartItems.length,
                            itemBuilder: (context, index) {
                              final cartItem = cartItems[index];
                              return CartTile(
                                cartItem: cartItem,
                                onRemoveItem: () {
                                  cartNotifier.removeFromCart(cartItem);
                                },
                                onReduceQuantity: () {
                                  cartItem.quantity > 1
                                      ? cartNotifier.reduceQuantity(cartItem)
                                      : cartNotifier.removeFromCart(cartItem);
                                },
                                onIncreaseQuantity: () {
                                  cartNotifier.addToCart(cartItem);
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
                                      controller: discountCode,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(9),
                                            borderSide: BorderSide(
                                                color: mainBlack
                                                    .withOpacity(0.7))),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    // Show a SnackBar
                                    discountCode.text != ''
                                        ? ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'Invalid Code. Please Try Again'),
                                            ),
                                          )
                                        : ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                            content:
                                                Text('Please Enter a code'),
                                          ));
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
                                      priceTextTh(cartNotifier.calcSubTotal()),
                                      style: const TextStyle(
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
                                      priceTextTh(
                                          cartNotifier.deliveryFee.toString()),
                                      style: const TextStyle(
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
                                  priceTextTh(cartNotifier.calcTotal()),
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
                                        builder: (context) =>
                                            MainScreen(index: 2)),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15)),
                                child: const Text(
                                  'Proceed to Checkout',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: mainBlack,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
