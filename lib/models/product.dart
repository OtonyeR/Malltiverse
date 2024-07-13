//Product model
class Product {
  final String name;
  final String imageUrl;
  final String description;
  final String displayPrice;
  final int currentPrice;
  final String category;
  int quantity;
  final int rating;

  Product(
      {required this.currentPrice,required this.name,
      required this.imageUrl,
      required this.description,
      required this.displayPrice,
      required this.category,
      required this.rating,
      required this.quantity});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'description': description,
      'price': displayPrice,
      'category': category,
      'quantity': quantity,
      'rating': rating,
    };
  }
}

final List productsInBag = [];
