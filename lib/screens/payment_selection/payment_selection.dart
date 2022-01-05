import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fms_flutter/screens/credit_cart_payment/credit_card_payment.dart';

class PaymentSelection extends StatefulWidget {
  const PaymentSelection({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PaymentSelection();
}

enum PaymentMethod { creditcart, transfer }

class _PaymentSelection extends State<PaymentSelection> {
  PaymentMethod? _character = PaymentMethod.creditcart;

  @override
  Widget build(BuildContext context) {
    print(_character);
    return Scaffold(
        bottomSheet: nextButton(),
        appBar: AppBar(
          title: const Text("Payment Selection"),
          backgroundColor: Colors.grey,
        ),
        body: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(10)),
            ListTile(
              title: const Text("Credit Cart"),
              trailing: Icon(Icons.credit_card),
              leading: Radio<PaymentMethod>(
                value: PaymentMethod.creditcart,
                groupValue: _character,
                onChanged: (PaymentMethod? value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              trailing: const Icon(Icons.account_balance),
              title: const Text('Bank Transfer'),
              leading: Radio<PaymentMethod>(
                value: PaymentMethod.transfer,
                groupValue: _character,
                onChanged: (PaymentMethod? value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
            ),
          ],
        ));
  }

  Widget nextButton() {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 60,
      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      width: size.width,
      child: TextButton(
          child: const Text(
            "Continue Payment",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.orange),
            elevation: MaterialStateProperty.all(2),
          ),
          onPressed: () async {
            if (_character == PaymentMethod.creditcart) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {return MySample(); } ));
            }
            else if(_character == PaymentMethod.transfer){
              print(_character);
            }
          }),
    );
  }
}
