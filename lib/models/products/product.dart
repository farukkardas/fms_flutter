class Product {
  int? id;
  String? name;
  num? price;
  num? categoryId;
  String? description;
  String? entryDate;
  int? sellerId;
  String? imagePath;

  Product(
      {this.id,
      this.name,
      this.price,
      this.categoryId,
      this.description,
      this.entryDate,
      this.sellerId,
      this.imagePath});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      id: json["id"],
      name: json["name"],
      price: json["price"],
      categoryId: json["categoryId"],
      description: json["description"],
      entryDate: json["entryDate"],
      sellerId: json["sellerId"],
      imagePath: json["imagePath"]);
}
