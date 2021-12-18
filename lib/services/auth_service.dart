import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fms_flutter/models/auth/login.dart';
import 'package:fms_flutter/models/auth/token_model.dart';
import 'package:fms_flutter/models/response_models/response_model.dart';
import 'package:fms_flutter/models/response_models/single_response_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Uri apiUrl = Uri.parse('http://localhost:5000/api/auth/login');


  Future<String> login(
      {TextEditingController? emailController,
      TextEditingController? passwordController}) async {
    final response = await http.post(apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String?, String?>{
          "email": emailController?.text,
          "password": passwordController?.text
        }));

    switch (response.statusCode) {
      case 200:
        const _storage = FlutterSecureStorage();
        //First parse JSON
        final jsonArray = json.decode(response.body);
        //Parse JSON Data
        final jsonData = jsonArray['data'] as Map;
        //Operation Claims
        final jsonRole = jsonData['operationClaims'] as List;

        // set role in storage
        for (var element in jsonRole) {
          _storage.write(key: "role", value: (element['name']));
        }

        // set values in flutter storage
        _storage.write(key: "jwt", value: jsonData['token'].toString());
        _storage.write(
            key: "expiration", value: jsonData['expiration'].toString());
        _storage.write(
            key: "securityKey", value: jsonData[' securityKey'].toString());
        _storage.write(key: "id", value: jsonData['id'].toString());

        return "Successfully logged!";

      case 400:
        final jsonArray = json.decode(response.body);
        String message = jsonArray['message'];
        return message;
      case 401:
        return "Response 403";
      case 403:
        return "Response 403";
      case 500:
        return "Internal server error!";
      default:
        return "Server is under maintenance or closed!";
    }
  }
}
