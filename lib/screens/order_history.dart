import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:malltiverse/providers/product_provider.dart';
import '../components/colors.dart';
import '../components/widgets/empty_view.dart';
import '../providers/history_provider.dart';
import 'history_details.dart';

class OrderHistoryScreen extends ConsumerStatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  ConsumerState<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends ConsumerState<OrderHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final orderHistory = ref.watch(orderHistoryProvider);
    final orderNotifier = ref.read(orderHistoryProvider.notifier);
    final product = ref.watch(productProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: mainWhite,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: mainBlack,
          ),
        ),
        title: const Text(
          'Order History',
          style: TextStyle(color: mainBlack),
        ),
      ),
      body: orderHistory.isEmpty
          ? const Center(child: EmptyListView())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: grey,
                    ),
                    child: const Center(
                      child:
                          Text('Order Summary', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  Expanded(
                    child: CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final orderItem = orderHistory[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          OrderDetailsScreen(order: orderItem),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: grey,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('ORDER SUCCESSFUL'),
                                      const Text(
                                          'Thank you for shopping with us'),
                                      const SizedBox(height: 8),
                                      // Replacing nested ListView with a Row
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.1978,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: orderItem.product.length,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            final product =
                                                orderItem.product[index];
                                            return Stack(children: [
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.1978,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.44,
                                                color: grey,
                                              ),
                                              Positioned.fill(
                                                child: Image.network(
                                                  product.imageUrl,
                                                  alignment: Alignment.center,
                                                  scale: 1.2,
                                                ),
                                              ),
                                            ]);
                                          },
                                        ),
                                      ),
                                      const Divider(),
                                      Text('Order #${orderItem.orderNumber}'),
                                      Text(
                                        '${orderItem.orderDate.weekday}/${orderItem.orderDate.day}/${orderItem.orderDate.month}/${orderItem.orderDate.year}',
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            childCount: orderHistory.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
