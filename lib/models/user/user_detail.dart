class UserDetail {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  int? city;
  String? district;
  String? address;
  int? zipCode;
  String? imagePath;
  int? profit;
  int? totalSales;
  int? customerCount;
  int? animalCount;
  int? sheepCount;
  int? cowCount;
  int? bullCount;
  int? calfCount;
  String? role;

  UserDetail(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.city,
      this.district,
      this.address,
      this.zipCode,
      this.imagePath,
      this.profit,
      this.totalSales,
      this.customerCount,
      this.animalCount,
      this.sheepCount,
      this.cowCount,
      this.bullCount,
      this.calfCount,
      this.role});

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
      id: json["id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      city: json["city"],
      district: json["district"],
      address: json["address"],
      zipCode: json["zipCode"],
      imagePath: json["imagePath"],
      profit: json["profit"],
      totalSales: json["totalSales"],
      customerCount: json["customerCount"],
      animalCount: json["animalCount"],
      sheepCount: json["sheepCount"],
      cowCount: json["cowCount"],
      bullCount: json["bullCount"],
      calfCount: json["calfCount"],
      role: json["role"]);
}
