class Product {
  int? id;
  String? name;
  double? price;
  String? description;
  String? entryDate;
  int? sellerId;
  String? imagePath;

  Product(
      {this.id,
      this.name,
      this.price,
      this.description,
      this.entryDate,
      this.sellerId,
      this.imagePath});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      id: json["id"],
      name: json["name"],
      price: json["price"],
      description: json["description"],
      entryDate: json["entryDate"],
      sellerId: json["sellerId"],
      imagePath: json["imagePath"]);
}
