import 'package:flutter/material.dart';
import 'package:fms_flutter/models/products/categories.dart';
import 'package:fms_flutter/models/products/product.dart';
import 'package:fms_flutter/screens/product_detail/product_detail.dart';
import 'package:fms_flutter/services/products_service.dart';
import 'package:intl/intl.dart';

class BuyProduct extends StatefulWidget {
  const BuyProduct({Key? key}) : super(key: key);

  @override
  State<BuyProduct> createState() => _BuyProduct();
}

class _BuyProduct extends State<BuyProduct> {
  List<Product> productList = <Product>[];
  final formatCurrency = NumberFormat.simpleCurrency(locale: "tr_TR");
  int activeMenu = 0;

  @override
  Widget build(BuildContext context) {
    ProductService().getAllProducts().then((value) => {
          //memory leakini önlemek için eğer mounted ise setState çalıştır
          if (mounted)
            {
              setState(() {
                productList = value.data!;
              })
            }
        });

    return Scaffold(body: cardBody());
  }

  Widget cardBody() {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                "Online Shopping",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Row(
                children: const [
                  Icon(Icons.search),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.shopping_cart)
                ],
              )
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(categories.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(left: 25, right: 10),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      activeMenu = index;
                    });
                  },
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(categories[index]),
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: activeMenu == index
                                  ? Colors.black
                                  : Colors.transparent,
                              width: 2)),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Wrap(
          children: List.generate(productList.length, (index) {
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ProductDetail(product: productList[index]);
                }));
              },
              child: Card(
                elevation: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Hero(
                      tag: productList[index].id.toString(),
                      child: Container(
                        width: (MediaQuery.of(context).size.width - 16) / 2,
                        height: (MediaQuery.of(context).size.width - 16) / 4,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "http://localhost:5000/uploads/" +
                                        productList[index].imagePath!),
                                fit: BoxFit.fill)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        productList[index].name ?? " ",
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        formatCurrency.format(productList[index].price),
                        style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            );
          }),
        )
      ],
    );
  }
}
