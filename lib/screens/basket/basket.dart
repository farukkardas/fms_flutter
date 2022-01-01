import 'package:flutter/material.dart';
import 'package:fms_flutter/models/basket/delete_basket_product.dart';
import 'package:fms_flutter/models/basket/get_basket_product.dart';
import 'package:fms_flutter/services/basket_service.dart';

class Basket extends StatefulWidget {
  const Basket({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Basket();
}

class _Basket extends State<Basket> {
  List<BasketProduct> productList = <BasketProduct>[];

  @override
  Widget build(BuildContext context) {
    BasketService().getBasketProducts().then((value) {
      if (mounted) {
        setState(() {
          productList = value.data!;
        });
      }
    });
    return Scaffold(
      appBar: basketAppBar(context),
      body: buildBody(context),
      bottomSheet: bottomButton(),
    );
  }

  DeleteBasketProduct deleteBasketProduct = DeleteBasketProduct();

  Widget bottomButton() {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: 60,
        width: size.width,
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text.rich(
                      TextSpan(text: "Total Price:\n", children: [
                        TextSpan(
                            text: calculatePrice() + " TL",
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w600))
                      ]),
                    ),
                  ),
                  const SizedBox(width: 80),
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: TextButton(
                        child: Text(
                          "Checkout " +
                              "(" +
                              productList.length.toString() +
                              ")",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.orange),
                          elevation: MaterialStateProperty.all(2),
                        ),
                        onPressed: () async {
//Buy products
                        }),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Column buildBody(BuildContext context) {
    return Column(
        children: List.generate(productList.length, (index) {
      return Material(
        color: Colors.white38,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
            child: Row(children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.25,
            height: MediaQuery.of(context).size.width * 0.2,
            child: AspectRatio(
              aspectRatio: 0.88,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Image.network(
                  "http://localhost:5000/uploads/" +
                      productList[index].imagePath!,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Text(
                productList[index].productName ?? "",
                style: const TextStyle(fontSize: 16, color: Colors.black),
                maxLines: 2,
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Text.rich(TextSpan(
                      text: productList[index].productPrice.toString() + " TL",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                          textBaseline: TextBaseline.alphabetic)))
                ],
              ),
            ],
          ),
          InkWell(
            onTap: () {
              showDialog(
                  barrierColor: Colors.black.withOpacity(0.5),
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: const Text(
                            "Do you want delete this item in basket?"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => {
                              deleteBasketProduct.id = productList[index].id.toString(),
                              BasketService()
                                  .deleteToBasket(deleteBasketProduct: deleteBasketProduct)
                                  .then((value) {
                               Navigator.pop(context, 'Cancel');
                              }).catchError((onError) {
                               Navigator.pop(context, 'Cancel');
                                print(onError);
                              })
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ));
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.delete),
            ),
          ),
        ], mainAxisAlignment: MainAxisAlignment.spaceBetween)),
      );
    }));
  }

  AppBar basketAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: Column(
        children: <Widget>[
          const Align(
              alignment: Alignment.center,
              child: Text(
                "Products in Basket",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
              )),
          const SizedBox(
            height: 5,
          ),
          Text(
            productList.length.toString() + " items",
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );
  }

  String calculatePrice() {
    num lastPrice = 0;
    for (final i in productList) {
      lastPrice += i.productPrice!;
    }
    return lastPrice.toString();
  }
}