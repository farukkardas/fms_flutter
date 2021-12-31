class ProductInBasket {
  int? id;
  String? userId;
  String? productId;

  Map<String, dynamic> toJson() =>{
    'userId' : userId,
    'productId' : productId
  };
}