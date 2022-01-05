import 'package:flutter/material.dart';
import 'package:fms_flutter/models/products/categories.dart';
import 'package:fms_flutter/models/products/product.dart';
import 'package:fms_flutter/screens/homepage/homepage.dart';
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
  List<Product> filteredList = <Product>[];
  final formatCurrency = NumberFormat.simpleCurrency(locale: "tr_TR");
  int activeMenu = 0;
  bool loaded = false;

  String searchValue = "";

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    ProductService().getAllProducts().then((value) => {
          //memory leakini önlemek için eğer mounted ise setState çalıştır
          if (mounted)
            {
              setState(() {
                if (activeMenu == 0) {
                  filteredList = value.data!;
                  if (searchValue.isNotEmpty) {
                    filteredList = value.data!;
                    var products = filteredList
                        .where((element) => element.name!
                            .toLowerCase()
                            .contains(searchValue.toLowerCase()))
                        .toList();
                    filteredList = products;
                  }
                } else {
                  filteredList.clear();
                  for (final rawValue in value.data!) {
                    if (rawValue.categoryId == activeMenu) {
                      filteredList.add(rawValue);
                      if (searchValue.isNotEmpty) {
                        filteredList = value.data!;
                        var products = filteredList
                            .where((element) =>
                                element.name!
                                    .toLowerCase()
                                    .contains(searchValue.toLowerCase()) &&
                                element.categoryId == activeMenu)
                            .toList();
                        filteredList = products;
                      }
                    }
                  }
                }
              })
            }
        });
    return Scaffold(
      body: cardBody(),
    );
  }

  Widget cardBody() {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                "Online Shopping",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        isVisible = !isVisible;
                      },
                      child: const Icon(Icons.search)),
                  const SizedBox(width: 20,),
                  InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Homepage(
                            selectedIndex: 1,
                          );
                        }));
                      },
                      child: const Icon(Icons.shopping_cart)),
                ],
              )
            ],
          ),
        ),
        Visibility(
          visible: isVisible,
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: TextField(
              onChanged: (value) => searchValue = value,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  labelText: 'Search..',
                  labelStyle: TextStyle(color: Colors.black),
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  )),
            ),
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
        listProducts()
      ],
    );
  }

  Wrap listProducts() {
    if (filteredList.isNotEmpty) {
      return Wrap(
        children: List.generate(filteredList.length, (index) {
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ProductDetail(product: filteredList[index]);
              }));
            },
            child: Card(
              elevation: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Hero(
                    tag: filteredList[index].id.toString(),
                    child: Container(
                      width: (MediaQuery.of(context).size.width - 16) / 2,
                      height: (MediaQuery.of(context).size.width - 16) / 4,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "http://localhost:5000/uploads/" +
                                      filteredList[index].imagePath!),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: SizedBox(
                      width: 160,
                      child: Text(
                        filteredList[index].name ?? " ",
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      formatCurrency.format(filteredList[index].price),
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
      );
    }
    return Wrap(
      children: <Widget>[
        const Padding(
            padding: EdgeInsets.only(top: 80, bottom: 80),
            child: Center(
                child: Text(
              "No product found in this category.",
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
            ))),
        Center(
            child: Image.asset(
          "assets/images/sad_cow.png",
          height: 150,
          width: 150,
        )),
      ],
    );
  }
}
