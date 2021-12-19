import 'dart:convert';
import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Uri loginUrl = Uri.parse('http://localhost:5000/api/auth/login');
  Uri checkSkUrl = Uri.parse('http://localhost:5000/api/auth/checkskoutdated');

  Future<String> login({TextEditingController? emailController,
    TextEditingController? passwordController}) async {
    final response = await http.post(loginUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String?, String?>{
          "email": emailController?.text,
          "password": passwordController?.text
        }));

    switch (response.statusCode) {
      case 200:
        SharedPreferences pref = await SharedPreferences.getInstance();
        //First parse JSON
        final jsonArray = json.decode(response.body);
        //Parse JSON Data
        final jsonData = jsonArray['data'] as Map;
        //Operation Claims
        final jsonRole = jsonData['operationClaims'] as List;

        // set role in storage
        for (var element in jsonRole) {
          pref.setString("role", element['name']);
        }

        // set values in sharedprefs
        pref.setString("jwt", jsonData['token'].toString());
        pref.setString("expiration", jsonData['expiration'].toString());
      //  pref.setString("securityKey", jsonData['securityKey'].toString());
        pref.setString("id", jsonData['id'].toString());
        pref.setBool("isAuth", true);
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

  Future<dynamic> postData(Map<String, String> body) async {
    return HttpRequest.postFormData(checkSkUrl.toString(), body)
        .then((HttpRequest resp) {
      return json.decode(resp.response);
    }).catchError((error ,stackTrace) {
      logout();
    });
  }

  logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }

}
