import 'dart:convert';
import 'package:fms_flutter/models/response_models/response_model.dart';
import 'package:fms_flutter/models/user/user_detail.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  Uri userDetailUrl =
      Uri.parse('http://localhost:5000/api/users/getuserdetails');
  Uri changerAddressUrl =
  Uri.parse('http://localhost:5000/api/users/changeaddress');

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
    userDetail = UserDetail.fromJson(parsedJson);

    return userDetail;
  }

  Future<ResponseModel> changerUserAddress({cityId=int,fullAddress=String}) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    ResponseModel responseModel = ResponseModel();
    var map = <String, dynamic>{};
    map['cityId'] = cityId.toString();
    map['fullAddress'] = fullAddress;
print(map);

    final response = await http.put(changerAddressUrl,headers: <String, String>{
      "Authorization": "Bearer " + pref.getString("jwt")!,
      'id': pref.getString("id")!,
      "securityKey": pref.getString("securityKey")!
    },body: map);

    switch(response.statusCode){
      case 200:
        var decodedJson = json.decode(response.body);
        responseModel.success = decodedJson['success'];
        responseModel.message = decodedJson['message'];
        return responseModel;
      case 400:
        var decodedJson = json.decode(response.body);
        if(decodedJson['message'].toString().isNotEmpty){
          responseModel.message = decodedJson['message'];
          responseModel.success = false;
          return responseModel;
        }
        else{
          var errors = decodedJson['Errors'];
          for(final i in errors){
            responseModel.message = i['ErrorMessage'];
          }
          responseModel.success = false;
          return responseModel;
        }
      case 500:
        var decodedJson = json.decode(response.body);
        responseModel.message = decodedJson['message'];
        responseModel.success = false;
        return responseModel;
    }

    return responseModel;
  }
}
