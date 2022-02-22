import 'dart:convert';
import 'package:fms_flutter/models/auth/login.dart';
import 'package:fms_flutter/models/auth/register_model.dart';
import 'package:fms_flutter/models/response_models/response_model.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class AuthService {
  Uri loginUrl = Uri.parse('http://localhost:5000/api/auth/login');
  Uri registerUrl = Uri.parse('http://localhost:5000/api/auth/register');
  Uri checkSkUrl = Uri.parse('http://localhost:5000/api/auth/checkskoutdated');

  Future<ResponseModel> login({loginModel = Login}) async {
    ResponseModel model = ResponseModel();
    final response = await http.post(loginUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(loginModel));

    switch (response.statusCode) {
      case 200:
        SharedPreferences pref = await SharedPreferences.getInstance();
        //First parse JSON
        final jsonArray = json.decode(response.body);
        //Parse JSON Data
        final jsonData = jsonArray['data'] as Map;
        //Operation Claims

        // set role in storage
        Map<String, dynamic> jwtDecode = Jwt.parseJwt(jsonData['token']);

        final roleKey = jwtDecode.keys.elementAt(3);
        final roleValue = jwtDecode[roleKey];

        final idKey = jwtDecode.keys.elementAt(0);
        final idValue = jwtDecode[idKey];

        // set values in sharedprefs
        pref.setString("role", roleValue);
        pref.setString("jwt", jsonData['token'].toString());
        pref.setString("expiration", jsonData['expiration'].toString());
        pref.setString("securityKey", jsonData['securityKey'].toString());
        pref.setString("id", idValue);
        pref.setBool("isAuth", true);
        model.message = jsonArray['message'];
        model.success = true;
        return model;

      case 400:
        final jsonArray = json.decode(response.body);
        String message = jsonArray['message'];
        model.message = message;
        model.success = false;
        return model;
      case 401:
        final jsonArray = json.decode(response.body);
        model.message = jsonArray['message'];
        model.success = false;
        return model;
      case 403:
        final jsonArray = json.decode(response.body);
        model.message = jsonArray['message'];
        model.success = false;
        return model;
      case 500:
        final jsonArray = json.decode(response.body);
        model.message = jsonArray['message'];
        model.success = false;
        return model;
      default:
        final jsonArray = json.decode(response.body);
        model.message = jsonArray['message'];
        model.success = false;
        return model;
    }
  }

  Future<ResponseModel> register({registerModel = RegisterModel}) async {
    ResponseModel model = ResponseModel();
    final response = await http.post(registerUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(registerModel));

    switch (response.statusCode) {
      case 200:
        final jsonArray = json.decode(utf8.decode(response.bodyBytes));
        model.message = await jsonArray["message"];
        model.success = true;
        SharedPreferences pref = await SharedPreferences.getInstance();
        //First parse JSON
        final registerJsonArray = json.decode(response.body);
        //Parse JSON Data
        final jsonData = registerJsonArray['data'] as Map;
        //Operation Claims
        final jsonRole = jsonData['operationClaims'] as List;

        for (var element in jsonRole) {
          pref.setString("role", element['name']);
        }

        pref.setString("jwt", jsonData['token'].toString());
        pref.setString("expiration", jsonData['expiration'].toString());
        pref.setString("securityKey", jsonData['securityKey'].toString());
        pref.setString("id", jsonData['id'].toString());
        pref.setBool("isAuth", true);

        return model;
      case 400:
        final jsonArray = json.decode(utf8.decode(response.bodyBytes));
        final errors = jsonArray['Errors'];
        final errorMessages = [];
        String errorMessage = "";
        for (final i in errors) {
          errorMessages.add(i["ErrorMessage"]);
        }

        for (final i in errorMessages) {
          errorMessage = i;
        }
        model.success = false;
        model.message = errorMessage;
        return model;
      case 500:
        model.success = false;
        return model;
      default:
        model.success = false;
        return model;
    }
  }

  Future<dynamic> postData(Map<String, String> body) async {
    var formData = FormData.fromMap(body);
    var dio = Dio();

    var response = await dio.post(checkSkUrl.toString(), data: formData);

    return response;
  }

  logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}
