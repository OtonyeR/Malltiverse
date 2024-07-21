import 'package:hive/hive.dart';
import 'package:malltiverse/models/product.dart';

part 'order_item.g.dart';

@HiveType(typeId: 1)
class OrderItem {
  @HiveField(0)
  final List<Product> product;

  @HiveField(1)
  final String paymentDetails;

  @HiveField(2)
  final String deliveryOption;

  @HiveField(3)
  final int orderStatus;

  @HiveField(4)
  final String statusMessage;

  @HiveField(5)
  final DateTime orderDate;

  @HiveField(6)
  final int orderNumber;

  @HiveField(7)
  final String subTotal;

  @HiveField(8)
  final int discount;

  @HiveField(9)
  final String delivery;

  @HiveField(10)
  final String total;

  @HiveField(11)
  final List<String> contacts;

  @HiveField(12)
  final int deliveryFee;

  @HiveField(13)
  final String productQuantity;

  OrderItem(
      {required this.subTotal,
      required this.discount,
      required this.delivery,
      required this.total,
      required this.deliveryFee,
      required this.paymentDetails,
      required this.deliveryOption,
      required this.orderStatus,
      required this.statusMessage,
      required this.orderDate,
      required this.orderNumber,
      required this.product,
      required this.contacts,
      required this.productQuantity});
}
