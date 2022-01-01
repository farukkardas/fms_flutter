class BasketProduct {
  int? id;
  int? productId;
  int? userId;
  String? productName;
  num? productPrice;
  String? description;
  String? imagePath;

  BasketProduct(
      {this.id,
      this.productId,
      this.userId,
      this.productName,
      this.productPrice,
      this.description,
      this.imagePath});

  factory BasketProduct.fromJson(Map<String, dynamic> json) => BasketProduct(
      id: json["id"],
      productId: json["productId"],
      userId: json["userId"],
      productName: json["productName"],
      productPrice: json["productPrice"],
      description: json["description"],
      imagePath: json["imagePath"]);
}
