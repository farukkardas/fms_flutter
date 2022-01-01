import 'dart:convert';

import 'package:fms_flutter/models/basket/basket_product.dart';
import 'package:fms_flutter/models/basket/delete_basket_product.dart';
import 'package:fms_flutter/models/basket/get_basket_product.dart';
import 'package:fms_flutter/models/response_models/list_response_model.dart';
import 'package:fms_flutter/models/response_models/response_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BasketService {
  Uri addBasketUrl = Uri.parse('http://localhost:5000/api/basket/addtobasket');
  Uri getBasketProductsUrl =
      Uri.parse('http://localhost:5000/api/basket/getbasketproducts');
  Uri deleteBasketProductsUrl =
      Uri.parse('http://localhost:5000/api/basket/deletetobasket');

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

  Future<ListResponseModel<BasketProduct>> getBasketProducts() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final products = ListResponseModel<BasketProduct>();

    var response =
        await http.get(getBasketProductsUrl, headers: <String, String>{
      "Content-Type": "application/json",
      "Authorization": "Bearer " + pref.getString("jwt")!,
      'id': pref.getString("id")!,
      "securityKey": pref.getString("securityKey")!
    });

    var parsedData = await (json.decode(response.body));
    var productData = await parsedData['data'];
    List<BasketProduct> productList = <BasketProduct>[];

    for (final i in productData) {
      BasketProduct toObject = BasketProduct.fromJson(i);
      productList.add(toObject);
    }
    products.data = productList;

    return products;
  }

  Future<ResponseModel> deleteToBasket({deleteBasketProduct = DeleteBasketProduct}) async {

    SharedPreferences pref = await SharedPreferences.getInstance();
    ResponseModel responseModel = ResponseModel();
    final response = await http.post(deleteBasketProductsUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + pref.getString("jwt").toString(),
          'id': pref.getString('id').toString(),
          'securityKey': pref.getString('securityKey').toString()
        },
        body: json.encode(deleteBasketProduct));

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
