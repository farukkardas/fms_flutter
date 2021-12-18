import 'package:fms_flutter/models/auth/operation_claims.dart';


class TokenModel {
  String? token;
  String? expiration;
  String? id;
  String? securityKey;
  OperationClaims? operationClaims;

  TokenModel(
      { this.token,
       this.expiration,
       this.id,
       this.securityKey,
       this.operationClaims});

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
        token: json['token'],
        expiration: json['expiration'],
        id: json['id'],
        securityKey: json['securityKey'],
        operationClaims: json['operationClaims']);
  }
}
