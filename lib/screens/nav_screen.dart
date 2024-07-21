import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:malltiverse/components/colors.dart';
import 'package:malltiverse/screens/cart_screen.dart';
import 'package:malltiverse/screens/checkout_screen.dart';
import 'package:malltiverse/screens/product_screen.dart';
import '../data/database.dart';
import '../providers/cart_provider.dart';

class MainScreen extends ConsumerStatefulWidget {
  int index;
  MainScreen({
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  // List of screens
  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    // Initialize pages
    _pages.add(const ProductPage());
    _pages.add(const CartScreen());
    _pages.add(const CheckOutScreen());
  }

  void _onItemTapped(int index) {
    setState(() {
      widget.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

    return Scaffold(
      body: IndexedStack(
        index: widget.index,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.103,
        color: mainWhite,
        child: Container(
          margin:
              const EdgeInsets.only(left: 24, right: 24, bottom: 16, top: 8),
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.1,
          ),
          height: MediaQuery.of(context).size.height * 0.072043,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: const Color.fromRGBO(42, 42, 42, 1),
          ),
          child: Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                runAlignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                spacing: 28,
                children: [
                  IconButton(
                    onPressed: () => _onItemTapped(0),
                    icon: widget.index == 0
                        ? CircleAvatar(
                            radius: 17,
                            backgroundColor: primaryColor,
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: SvgPicture.asset(
                                'assets/home.svg',
                                color: const Color.fromRGBO(42, 42, 42, 1),
                              ),
                            ),
                          )
                        : SizedBox(
                            width: 24,
                            height: 24,
                            child: SvgPicture.asset(
                              'assets/home.svg',
                              color: const Color.fromRGBO(250, 250, 250, 1),
                            ),
                          ),
                  ),
                  IconButton(
                    onPressed: () => _onItemTapped(1),
                    icon: widget.index == 1
                        ? Stack(
                            children: [
                              CircleAvatar(
                                radius: 17,
                                backgroundColor: primaryColor,
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: SvgPicture.asset(
                                    'assets/shopping-cart.svg',
                                    color: const Color.fromRGBO(42, 42, 42, 1),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 2,
                                top: 4,
                                child: Visibility(
                                  visible: cartItems.isEmpty ? false : true,
                                  child: CircleAvatar(
                                    radius: 6,
                                    backgroundColor: Colors.redAccent,
                                    child: Center(
                                        child: Text(
                                      cartNotifier.calcTotalQuantity(),
                                      style: const TextStyle(fontSize: 10),
                                    )),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Stack(
                            children: [
                              SizedBox(
                                width: 24,
                                height: 24,
                                child: SvgPicture.asset(
                                  'assets/shopping-cart.svg',
                                  color: const Color.fromRGBO(250, 250, 250, 1),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Visibility(
                                  visible: cartItems.isEmpty ? false : true,
                                  child: CircleAvatar(
                                    radius: 6,
                                    backgroundColor: Colors.redAccent,
                                    child: Center(
                                        child: Text(
                                      cartNotifier.calcTotalQuantity(),
                                      style: const TextStyle(fontSize: 10),
                                    )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                  IconButton(
                    onPressed: () => _onItemTapped(2),
                    icon: widget.index == 2
                        ? CircleAvatar(
                            radius: 17,
                            backgroundColor: primaryColor,
                            child: SizedBox(
                              width: 26,
                              height: 26,
                              child: SvgPicture.asset(
                                'assets/Group 2238.svg',
                                color: const Color.fromRGBO(42, 42, 42, 1),
                              ),
                            ),
                          )
                        : SizedBox(
                            width: 22,
                            height: 32.5,
                            child: SvgPicture.asset(
                              'assets/Group 2238.svg',
                              color: const Color.fromRGBO(250, 250, 250, 1),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
