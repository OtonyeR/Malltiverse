import 'package:hive/hive.dart';

part 'product.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String category;

  @HiveField(3)
  final String imageUrl;

  @HiveField(4)
  final String description;

  @HiveField(5)
  final int currentPrice;

  @HiveField(6)
  int quantity = 0;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.description,
    required this.currentPrice,
    required this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      category: (json['categories'] != null && json['categories'].isNotEmpty)
          ? json['categories'][0]['name']
          : 'Unknown',
      imageUrl: (json['photos'] != null && json['photos'].isNotEmpty)
          ? 'https://api.timbu.cloud/images/${json['photos'][0]['url']}'
          : '',
      description: json['description'] ?? '',
      currentPrice: (json['current_price'] != null &&
              json['current_price'].isNotEmpty &&
              json['current_price'][0] != null)
          ? json['current_price'][0]['NGN'][0].toInt()
          : null,
      quantity: 0,
    );
  }
}
