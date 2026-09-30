class Product {
  final int? id;             // ✏️ جديد
  final String name;
  final String image;
  final String rating;
  final String reviews;
  final String price;
  final String oldPrice;

  const Product({
    this.id,                 // ✏️
    required this.name,
    required this.image,
    required this.rating,
    required this.reviews,
    required this.price,
    required this.oldPrice,
  });
}