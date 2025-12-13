class Product {
  int id;
  String title;
  dynamic price;
  String description;
  String category;
  String image;
  // Thay vì dùng object Rating, ta khai báo trực tiếp các thuộc tính cần dùng
  double rate;
  int count;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rate,
    required this.count,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"] ?? 0,
      title: json["title"] ?? '',
      price: json["price"] ?? 0,
      description: json["description"] ?? '',
      category: json["category"] ?? '',
      image: json["image"] ?? '',
      rate: json["rating"] != null ? (json["rating"]["rate"] as num).toDouble() : 0.0,
      count: json["rating"] != null ? (json["rating"]["count"] as num).toInt() : 0,
    );
  }
}