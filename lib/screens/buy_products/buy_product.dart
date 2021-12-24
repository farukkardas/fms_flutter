import 'package:flutter/material.dart';
import 'package:fms_flutter/models/products/product.dart';
import 'package:fms_flutter/services/products_service.dart';

class BuyProduct extends StatefulWidget {
  @override
  State<BuyProduct> createState() => _BuyProduct();
}

class _BuyProduct extends State<BuyProduct> {
  List<Product> productList = <Product>[];

  @override
  Widget build(BuildContext context) {
    ProductService()
        .getAllProducts()
        .then((value) => {productList = value.data!});
    return Scaffold(
        body: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: productList.length,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 50,
              child: Center(child: Text('Entry ${productList[index].name}')),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
        ));
  }
}
