class OrderDetail {
  int? id;
  int? sellerId;
  int? productId;
  num? price;
  int? customerId;
  String? sellerName;
  String? customerName;
  int? productType;
  String? imagePath;
  String? productName;
  int? deliveryCity;
  String? deliveryDistrict;
  String? deliveryAddress;
  String? boughtDate;
  int? status;
  int? deliveryNo;

  OrderDetail(
      {this.id,
      this.sellerId,
      this.productId,
        this.price,
        this.customerId,
      this.sellerName,
      this.customerName,
      this.productType,
        this.imagePath,
      this.productName,
      this.deliveryCity,
      this.deliveryDistrict,
      this.deliveryAddress,
      this.boughtDate,
      this.status,
      this.deliveryNo});

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
      id: json["id"],
      sellerId: json["sellerId"],
      productId: json["productId"],
      price : json["price"],
      customerId:json["customerId"],
      sellerName: json["sellerName"],
      customerName: json["customerName"],
      productType: json["productType"],
      imagePath : json["imagePath"],
      productName: json["productName"],
      deliveryCity: json["deliveryCity"],
      deliveryDistrict: json["deliveryDistrict"],
      deliveryAddress: json["deliveryAddress"],
      boughtDate: json["boughtDate"],
      status: json["status"],
      deliveryNo: json["deliveryNo"]);
}
