class Product {
  final int id;
  final String title;
  final String desc;
  final String category;
  final double price;
  final String thumbnail;
  final List<String> images;
  final double rating;
  final double discountPercentage;

  Product({
    required this.id,
    required this.title,
    required this.desc,
    required this.category,
    required this.price,
    required this.thumbnail,
    required this.images,
    required this.rating,
    required this.discountPercentage,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] != null ? (json['id'] as num).toInt() : 0,
      title: json['title']?.toString() ?? "",
      desc: json['description']?.toString() ?? "",
      category: json['category']?.toString() ?? "",
      price: json['price'] != null ? (json['price'] as num).toDouble() : 0.0,
      thumbnail: json['thumbnail']?.toString() ?? "",
      discountPercentage: json['discountPercentage'] != null
          ? (json['discountPercentage'] as num).toDouble()
          : 0.0,
      rating: json['rating'] != null ? (json['rating'] as num).toDouble() : 0.0,
      images: json['images'] != null
          ? (json['images'] as List).map((image) => image.toString()).toList()
          : <String>[],
    );
  }
}
