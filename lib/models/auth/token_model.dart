class TokenModel {
  String? token;
  String? expiration;
  String? securityKey;

  TokenModel(
      { this.token,
       this.expiration,
       this.securityKey,
       });

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
        token: json['token'],
        expiration: json['expiration'],
        securityKey: json['securityKey']);
  }
}
