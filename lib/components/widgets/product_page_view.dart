import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:malltiverse/components/widgets/product_tile.dart';
import 'package:malltiverse/providers/product_provider.dart';
import 'package:malltiverse/providers/wishlist_provider.dart';
import 'package:malltiverse/services/api_services.dart';
import '../../models/product.dart';
import '../../providers/cart_provider.dart';
import '../colors.dart';
import 'error_box.dart';

class ProductsSection extends ConsumerStatefulWidget {
  final String categoryName;
  final List<Product> categoryProducts;
  final bool top;
  const ProductsSection({
    Key? key,
    required this.categoryName,
    required this.top,
    required this.categoryProducts,
  }) : super(key: key);

  @override
  ConsumerState<ProductsSection> createState() => _ProductsSectionState();
}

class _ProductsSectionState extends ConsumerState<ProductsSection> {
  final PageController _controller = PageController();
  int _currentIndex = 0;
  Map<String, String> _ratings = {};

  @override
  void initState() {
    super.initState();
    _fetchRatings();
  }

  Future<void> _fetchRatings() async {
    Map<String, String> ratings = {};
    for (var product in widget.categoryProducts) {
      final rating = await ApiService().getInfo(product.id);
      ratings[product.id] = rating;
    }
    setState(() {
      _ratings = ratings;
    });
  }

  @override
  Widget build(BuildContext context) {
    int itemsPerPage = 2;
    int numPages = (widget.categoryProducts.length / itemsPerPage).ceil();
    final cartNotifier = ref.read(cartProvider.notifier);
    final wishNotifier = ref.read(wishlistProvider.notifier);
    final wishItems = ref.watch(wishlistProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.categoryName,
          style: const TextStyle(
            fontSize: 20,
            color: mainBlack,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: widget.top == true ? 16 : 22),
        SizedBox(
          height: 346,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
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
                    List<Product> pageProducts =
                        widget.categoryProducts.sublist(
                      startIndex,
                      endIndex > widget.categoryProducts.length
                          ? widget.categoryProducts.length
                          : endIndex,
                    );
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: pageProducts.map((product) {
                        Center(
                          child: ErrorBox(
                              message:
                                  'We seem to be having connection troubles',
                              onPressed: () async {
                                await ref
                                    .read(productProvider.notifier)
                                    .fetchProducts();
                              }),
                        );
                        final rating = _ratings[product.id] ?? '0';
                        return ProductTile(
                          product: product,
                          onAddToCart: () {
                            cartNotifier.addToCart(product);
                            if (wishItems.any(
                                    (element) => element.id == product.id) ==
                                true) {
                              wishNotifier.removeProduct(product.id);
                            }
                          },
                          productRating: rating,
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
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
        const SizedBox(height: 32),
      ],
    );
  }
}
