import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:malltiverse/components/colors.dart';
import 'package:malltiverse/components/widgets/ad_box.dart';
import 'package:malltiverse/components/widgets/error_box.dart';
import 'package:malltiverse/components/widgets/pop_menu.dart';
import 'package:malltiverse/components/widgets/product_page_view.dart';
import 'package:malltiverse/providers/product_provider.dart';

import '../models/product.dart';

class ProductPage extends ConsumerStatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends ConsumerState<ProductPage> {
  final List<String> categories = [
    'Tech Gadget',
    'Men\'s Fashion',
    'Women\'s Fashion',
  ];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      await ref.read(productProvider.notifier).fetchProducts();
    } finally {
      // Simulate a loading period of 2 seconds before displaying the content
      await Future.delayed(
        Duration(seconds: 2),
      );
      ref.read(loadingStateProvider.notifier).state = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productProvider);
    final isLoading = ref.watch(loadingStateProvider);

    return Scaffold(
      backgroundColor: mainWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: mainWhite,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 14.0),
            child: PopUpMenu(),
          ),
        ],
        leading: Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Image.asset('assets/Malltiverse Logo.png'),
        ),
        leadingWidth: 100,
        title: const Text(
          'Product List',
          style: TextStyle(color: mainBlack),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SafeArea(
          child: Column(
            children: [
              const ProductAd(),
              const SizedBox(height: 32),
              Expanded(
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                        color: primaryColor,
                      ))
                    : products.isEmpty
                        ? Center(
                            child: ErrorBox(
                              message:
                                  'We seem to be having connection troubles',
                              onPressed: () {
                                ref.read(loadingStateProvider.notifier).state =
                                    true; // Show loading icon
                                _loadProducts();
                              },
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: () async {
                              await ref
                                  .read(productProvider.notifier)
                                  .fetchProducts();
                            },
                            color: Colors.black87,
                            child: ListView.builder(
                              padding: const EdgeInsets.only(bottom: 20),
                              physics: const BouncingScrollPhysics(),
                              itemCount: categories.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ProductsSection(
                                  top: true,
                                  categoryName: categories[index],
                                  categoryProducts: filterByCategory(
                                    categories[index].toLowerCase(),
                                    products,
                                  ),
                                );
                              },
                            ),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to filter products by category
  List<Product> filterByCategory(String cat, List<Product> allProducts) {
    return allProducts.where((product) => product.category == cat).toList();
  }
}
