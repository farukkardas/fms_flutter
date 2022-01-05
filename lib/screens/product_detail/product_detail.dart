import 'package:fms_flutter/models/basket/basket_product.dart';
import 'package:fms_flutter/services/basket_service.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fms_flutter/models/products/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final formatCurrency = NumberFormat.simpleCurrency(locale: "tr_TR");
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: detailBody(),
      bottomSheet: bottomButton(),
    );
  }

  Widget bottomButton() {
    Size size = MediaQuery.of(context).size;
    ProductInBasket productInBasket = ProductInBasket();
    return Container(
      height: 60,
      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      width: size.width,
      child: TextButton(
          child: const Text(
            "Add To Cart",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.orange),
            elevation: MaterialStateProperty.all(2),
          ),
          onPressed: ()  async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            productInBasket.userId = prefs.getString('id');
            productInBasket.productId = widget.product.id.toString();
            BasketService().addToBasket(productInBasket: productInBasket).then((value) {
              bool isSuccess = true;

              if(value.success == false){
                isSuccess = false;
              }

              final snackBar = SnackBar(
                  backgroundColor: isSuccess ? Colors.green : Colors.red,
                  content: Text(
                    value.message!,
                    textAlign: TextAlign.center,
                  ));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }).catchError((onError) {
              const snackBar = SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(
                    "Error occurred when try to add basket!",
                    textAlign: TextAlign.center,
                  ));

              ScaffoldMessenger.of(context).showSnackBar(snackBar);

            });

          }),
    );
  }

  Widget detailBody() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: InkWell(
                hoverColor: Colors.transparent,
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Align(
                    alignment: Alignment.topLeft,
                    child: Icon(Icons.arrow_back_ios)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              elevation: 20,
              child: Hero(
                tag: widget.product.id.toString(),
                child: SizedBox(
                  height: 300,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(fit: BoxFit.fill,
                      image: NetworkImage("http://localhost:5000/uploads/" +
                          widget.product.imagePath!),
                    )),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text("Product Name: ",
                      style: TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          fontWeight: FontWeight.bold)),
                  Flexible(
                    child: Text(
                      widget.product.name ?? "Product name not found!",
                      style: const TextStyle(fontSize: 16, height: 1.5),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text("Description: ",
                      style: TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          fontWeight: FontWeight.bold)),
                  Flexible(
                    child: Text(
                      widget.product.description ?? "Description not found!",
                      style: const TextStyle(fontSize: 16, height: 1.5),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text("Price: ",
                      style: TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          fontWeight: FontWeight.bold)),
                  Flexible(
                    child: Text(
                      formatCurrency.format(widget.product.price),
                      style: const TextStyle(fontSize: 16, height: 1.5),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text("Product ID: ",
                      style: TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          fontWeight: FontWeight.bold)),
                  Text(
                    widget.product.id!.toString(),
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
