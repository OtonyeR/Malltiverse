import 'package:flutter/material.dart';
import 'package:malltiverse/models/order_item.dart';

import '../components/colors.dart';
import '../components/widgets/custom_divider.dart';
import '../components/widgets/price_tag.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderItem order;

  OrderDetailsScreen({required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainWhite,
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
          'Order Details',
          style: TextStyle(color: mainBlack),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Order Number: ${order.orderNumber}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text(
                  'Order Date: ${order.orderDate.day}/${order.orderDate.month}/${order.orderDate.year}',
                  style: TextStyle(fontSize: 16)),
              const SizedBox(height: 16),
              const Text('Products Ordered',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ListView.builder(
                shrinkWrap: true, // Added to make ListView fit its content
                physics:
                    const NeverScrollableScrollPhysics(), // Disable inner scrolling
                itemCount: order.product.length,
                itemBuilder: (context, index) {
                  final product = order.product[index];
                  return ListTile(
                    title: Text(product.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text('Quantity: ${product.quantity}'),
                        const SizedBox(height: 4),
                        Text(
                            'Price: ${priceTextTh(product.currentPrice.toString())}'),
                      ],
                    ),
                  );
                },
              ),
              Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.symmetric(vertical: 20),
                padding: const EdgeInsets.only(
                    left: 17, top: 20, right: 15, bottom: 18),
                decoration: BoxDecoration(
                    color: grey, borderRadius: BorderRadius.circular(4.0)),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        order.paymentDetails,
                        style: TextStyle(
                          fontSize: 16,
                          color: mainBlack,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.only(bottom: 31),
                padding: const EdgeInsets.only(
                    left: 17, top: 20, right: 15, bottom: 18),
                decoration: BoxDecoration(
                    color: grey, borderRadius: BorderRadius.circular(4.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Delivery Details - ${order.deliveryOption}',
                        style: TextStyle(
                          fontSize: 16,
                          color: mainBlack,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(order.delivery, style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.only(bottom: 31),
                padding: const EdgeInsets.only(
                    left: 17, top: 20, right: 15, bottom: 18),
                decoration: BoxDecoration(
                    color: grey, borderRadius: BorderRadius.circular(4.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Contact Information',
                        style: TextStyle(
                          fontSize: 16,
                          color: mainBlack,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (order.contacts.isNotEmpty)
                      Text(order.contacts[0], style: TextStyle(fontSize: 16))
                    else
                      Text('No contact information available',
                          style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.only(bottom: 31),
                padding: const EdgeInsets.only(
                    left: 17, top: 20, right: 15, bottom: 18),
                decoration: BoxDecoration(
                    color: grey, borderRadius: BorderRadius.circular(4.0)),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Order Total',
                        style: TextStyle(
                          fontSize: 16,
                          color: mainBlack,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              priceTextTh(order.subTotal),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              priceTextTh(order.deliveryFee.toString()),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Discount Amount',
                              style: TextStyle(
                                fontSize: 12,
                                color: mainBlack.withOpacity(0.7),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              priceTextTh(order.discount.toString()),
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
                          priceTextTh(order.total.toString()),
                          style: const TextStyle(
                            fontSize: 14,
                            color: mainBlack,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 35),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
