import 'dart:convert';

import 'package:fms_flutter/models/orders/order-detail.dart';
import 'package:fms_flutter/models/response_models/list_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OrderService{

  Future<ListResponseModel<OrderDetail>> getUserOrderDetail() async {
    Uri ordersUrl =  Uri.parse("http://localhost:5000/api/orders/getcustomerorders");
    SharedPreferences pref = await SharedPreferences.getInstance();
    final orders = ListResponseModel<OrderDetail>();

    var response = await http.get(ordersUrl, headers: <String, String>{
      "Content-Type": "application/json",
      "Authorization": "Bearer " + pref.getString("jwt")!,
      'id': pref.getString("id")!,
      "securityKey": pref.getString("securityKey")!
    });
    var parsedJson = json.decode(response.body);
    List<OrderDetail> orderList = <OrderDetail>[];

    for(final i in parsedJson['data']){
      OrderDetail toOrder = OrderDetail.fromJson(i);
      orderList.add(toOrder);
    }
    orders.data = orderList;

    return orders;
}

}