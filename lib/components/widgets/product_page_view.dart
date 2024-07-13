import 'package:flutter/material.dart';
import 'package:malltiverse/components/widgets/product_tile.dart';
import 'package:malltiverse/product_data.dart';

import '../../models/cart.dart';
import '../../models/product.dart';
import '../colors.dart';

class ProductsSection extends StatefulWidget {
  final String categoryName;
  final bool top;
  final Cart cart;
  const ProductsSection({
    Key? key,
    required this.categoryName,
    required this.top,
    required this.cart,
  }) : super(key: key);

  @override
  State<ProductsSection> createState() => _ProductsSectionState();
}

class _ProductsSectionState extends State<ProductsSection> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  List<Product> getFilteredProducts() {
    return productData
        .where((product) => product.category == widget.categoryName)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    int itemsPerPage = 2;
    List<Product> categoryProducts = getFilteredProducts();
    int numPages = (categoryProducts.length / itemsPerPage).ceil();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.categoryName,
          style: const TextStyle(
            fontSize: 20,
            color: mainBlack,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: widget.top == true ? 16 : 28),
        SizedBox(
          height: 346,
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemCount: numPages,
                  itemBuilder: (context, pageIndex) {
                    int startIndex = pageIndex * itemsPerPage;
                    int endIndex = startIndex + itemsPerPage;
                    List<Product> pageProducts = categoryProducts.sublist(
                      startIndex,
                      endIndex > categoryProducts.length
                          ? categoryProducts.length
                          : endIndex,
                    );
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: pageProducts
                          .map((product) => ProductTile(
                                product: product,
                                onTap: () {
                                  widget.cart.addToCart(product);
                                },
                              ))
                          .toList(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(numPages, (index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              width: 8.0,
              height: 8.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index ? primaryColor : Colors.grey,
              ),
            );
          }),
        ),
      ],
    );
  }
}
