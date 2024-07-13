import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:malltiverse/components/colors.dart';
import 'package:malltiverse/screens/cart_screen.dart';
import 'package:malltiverse/screens/checkout_screen.dart';
import 'package:malltiverse/screens/product_screen.dart';

import 'models/cart.dart';

class BaseScreen extends StatefulWidget {
  final Widget child;
  final String title;
  final bool showLogo;
  final Cart cart;

  BaseScreen(
      {Key? key,
      required this.child,
      required this.cart,
      required this.title,
      required this.showLogo})
      : super(key: key);

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Add your navigation logic here
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductPage(cart: widget.cart)),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CartScreen(cart: widget.cart)),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CheckOutScreen(cart: widget.cart)),
        );
        break;
      default:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductPage(cart: widget.cart)),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        title: Text(
          widget.title,
          style: TextStyle(color: Color.fromRGBO(42, 42, 42, 1)),
        ),
        centerTitle: true,
      ),
      body: SafeArea(child: widget.child),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 24.0, right: 24, bottom: 23),
        child: SafeArea(
          child: Container(
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
                      icon: _selectedIndex == 0
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
                      icon: _selectedIndex == 1
                          ? CircleAvatar(
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
                            )
                          : SizedBox(
                              width: 24,
                              height: 24,
                              child: SvgPicture.asset(
                                'assets/shopping-cart.svg',
                                color: const Color.fromRGBO(250, 250, 250, 1),
                              ),
                            ),
                    ),
                    IconButton(
                      onPressed: () => _onItemTapped(2),
                      icon: _selectedIndex == 2
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
      ),
    );
  }
}
