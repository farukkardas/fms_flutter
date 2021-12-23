import 'dart:convert';
import 'package:fms_flutter/models/user/user_detail.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  Uri userDetailUrl =
      Uri.parse('http://localhost:5000/api/users/getuserdetails');

  Future<UserDetail> getUserDetails() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    UserDetail userDetail = UserDetail();

    final response = await http.get(userDetailUrl, headers: <String, String>{
      "Content-Type": "application/json",
      "Authorization": "Bearer " + pref.getString("jwt")!,
      'id': pref.getString("id")!,
      "securityKey": pref.getString("securityKey")!
    });

    final parsedJson = await json.decode(response.body)['data'];
    userDetail =  UserDetail.fromJson(parsedJson);

    return userDetail;
  }
}
