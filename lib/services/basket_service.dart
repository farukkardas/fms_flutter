import 'dart:convert';

import 'package:fms_flutter/models/basket/basket_product.dart';
import 'package:fms_flutter/models/response_models/response_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BasketService {
  Uri addBasketUrl = Uri.parse('http://localhost:5000/api/basket/addtobasket');

  Future<ResponseModel> addToBasket({productInBasket = ProductInBasket}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    ResponseModel responseModel = ResponseModel();
    final response = await http.post(addBasketUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + pref.getString("jwt").toString(),
          'id': pref.getString('id').toString(),
          'securityKey': pref.getString('securityKey').toString()
        },
        body: json.encode(productInBasket));

    print(json.encode(productInBasket));
    switch (response.statusCode) {
      case 200:
        final jsonArray = json.decode(response.body);
        final jsonMessage = jsonArray['message'];
        responseModel.message = jsonMessage;
        responseModel.success = true;
        return responseModel;
      case 400:
        final jsonArray = json.decode(response.body);
        final jsonMessage = jsonArray['message'];
        responseModel.message = jsonMessage;
        responseModel.success = false;
        return responseModel;
      case 500:
        final jsonArray = json.decode(response.body);
        final jsonMessage = jsonArray['message'];
        responseModel.message = jsonMessage;
        responseModel.success = false;
        return responseModel;
      default:
        final jsonArray = json.decode(response.body);
        responseModel.message = jsonArray['message'];
        responseModel.success = false;
        return responseModel;
    }
  }
}
