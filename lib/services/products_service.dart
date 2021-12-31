import 'dart:convert';
import 'package:fms_flutter/models/products/product.dart';
import 'package:fms_flutter/models/response_models/list_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductService {
  Uri getAllProductsUrl =
      Uri.parse('http://localhost:5000/api/productsonsale/getall');
  final products = ListResponseModel<Product>();

  Future<ListResponseModel<Product>> getAllProducts() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var response = await http.get(getAllProductsUrl, headers: <String, String>{
      "Content-Type": "application/json",
      "Authorization": "Bearer " + pref.getString("jwt")!,
      'id': pref.getString("id")!,
      "securityKey": pref.getString("securityKey")!
    });

    var parsedData = await (json.decode(response.body));
    var productData = await parsedData['data'];
    List<Product> productList = <Product>[];

    for (final i in productData) {
      Product toObject = Product.fromJson(i);
      productList.add(toObject);
    }
    products.data = productList;

    return products;
  }
}
