import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fms_flutter/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthGuard {
  Future<bool> checkUserAuth() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final id = pref.getString("id");
    final jwt = pref.getString("jwt");
    var lastResponse;
    Map<String, String> body = <String, String>{'id': id ?? ""};

    await AuthService().postData(body).then((value) async {
      lastResponse = value;
    }).catchError((responseError) {
      AuthService().logout();
    });

    if (!lastResponse.toString().contains("up to date") || jwt == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> checkIfLogged({context = BuildContext}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    final securityKey = pref.getString("securityKey");
    if (securityKey == null) {
      return true;
    } else {
      return false;
    }
  }
}
