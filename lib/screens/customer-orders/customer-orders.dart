import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fms_flutter/constants/order-status.dart';
import 'package:fms_flutter/models/orders/order-detail.dart';
import 'package:fms_flutter/screens/product_detail/product_detail.dart';
import 'package:fms_flutter/services/order_service.dart';

class CustomerOrders extends StatefulWidget {
  const CustomerOrders({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomerOrders();
}

class _CustomerOrders extends State<CustomerOrders> {
  List<OrderDetail> orderDetails = <OrderDetail>[];

  @override
  Widget build(BuildContext context) {
    getUserOrders();
    return Scaffold(
        appBar: AppBar(
          title: Text("My orders"),
        ),
        body: buildBody());
  }

  buildBody() {
    return Wrap(
      children: List.generate(orderDetails.length, (index) {
        return InkWell(
          onTap: () {
          },
          child: Card(
            elevation: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, top: 20, bottom: 20, right: 10),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "http://localhost:5000/uploads/" +
                                          orderDetails[index].imagePath!),
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        child: Text(
                          orderDetails[index].productName ?? "No data found..",
                          overflow: TextOverflow.fade,
                          maxLines: 2,
                          softWrap: false,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 10,right: 20),
                      child: SizedBox(
                        child: Text(
                          orderDetails[index].price.toString() + " TL",
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          softWrap: false,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Text(
                        "Order Status: \n\n" +
                            OrderStatus
                                .status[orderDetails[index].status ?? 0],
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade,
                        maxLines: 3,
                        softWrap: false,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: SizedBox(
                          child: Image.asset( "assets/icons/" +
                              OrderStatus.status[orderDetails[index].status!]
                                  .toString()
                                  .toLowerCase() +
                              ".png")
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );

  }

  getUserOrders() {
    OrderService().getUserOrderDetail().then((value) {
      setState(() {
        orderDetails = value.data!;
      });
    });
  }
}
