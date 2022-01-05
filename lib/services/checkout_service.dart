import 'dart:convert';

import 'package:fms_flutter/models/response_models/response_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutService {
  Future<ResponseModel> checkOutProducts(
      {fullName, cartNumber, cvvNumber, expirationDate}) async {
    Uri checkoutProductsUrl =  Uri.parse("http://localhost:5000/api/checkout/checkoutproducts");
    ResponseModel responseModel = ResponseModel();
    SharedPreferences pref = await SharedPreferences.getInstance();

    var jsonObject = <String, dynamic>{
      "fullName": fullName,
      "cartNumber": cartNumber,
      "cvvNumber": cvvNumber,
      "expirationDate": expirationDate
    };

    final response = await http.post(checkoutProductsUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + pref.getString("jwt").toString(),
          'id': pref.getString('id').toString(),
          'securityKey': pref.getString('securityKey').toString()
        },
        body: json.encode(jsonObject));

    switch(response.statusCode){
      case 200:
       var decodedJson = json.decode(response.body);
        responseModel.success = decodedJson['success'];
        responseModel.message = decodedJson['message'];
        return responseModel;
      case 400:
       var decodedJson = json.decode(response.body);
       print(decodedJson);
       var errors = decodedJson['Errors'];
       for(final i in errors){
         responseModel.message = i['ErrorMessage'];
       }
       responseModel.success = false;
       return responseModel;

      case 500:
        var decodedJson = json.decode(response.body);
        print(decodedJson);
        responseModel.success = false;
        return responseModel;
    }

    return responseModel;
  }
}
