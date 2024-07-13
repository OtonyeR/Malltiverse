import 'package:flutter/material.dart';
import 'package:malltiverse/components/colors.dart';
import 'package:malltiverse/components/widgets/ad_box.dart';
import 'package:malltiverse/models/product.dart';
import 'package:malltiverse/navigation_menu.dart';
import 'package:malltiverse/product_data.dart';
import '../components/widgets/product_page_view.dart';
import '../components/widgets/product_tile.dart';
import '../models/cart.dart';

class ProductPage extends StatefulWidget {
  final Cart cart;
  const ProductPage({Key? key, required this.cart}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      cart: widget.cart,
      title: 'Product List',
      showLogo: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 23),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              ProductAd(),
              SizedBox(
                height: 44,
              ),
              ProductsSection(
                top: true,
                categoryName: 'Tech Gadget',
                cart: widget.cart,
              ),
              SizedBox(
                height: 20,
              ),
              ProductsSection(
                  top: false,
                  categoryName: 'Men\'s Fashion',
                  cart: widget.cart),
              SizedBox(
                height: 20,
              ),
              ProductsSection(
                  top: false,
                  categoryName: 'Women\'s Fashion',
                  cart: widget.cart)
            ],
          ),
        ),
      ),
    );
  }
}
