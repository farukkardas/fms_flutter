import 'dart:core';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:fms_flutter/guards/auth_guard.dart';
import 'package:fms_flutter/screens/buy_products/buy_product.dart';
import 'package:fms_flutter/screens/profile/profile.dart';
import 'package:fms_flutter/screens/welcome/welcome_screen.dart';
import 'package:fms_flutter/services/auth_service.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomePageState();
}

class _HomePageState extends State<Homepage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    const BuyProduct(),
    const Text(
      'Index 2: School',
      style: optionStyle,
    ),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {

    if(mounted){
      setState(() {
        _selectedIndex = index;
      });
    }

  }

  bool isAuth = false;

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        Duration.zero,
        () => AuthGuard().checkUserAuth().then((value) => {
              isAuth = value,
              if (isAuth == false)
                {
                  AuthService().logout(),
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) {
                    return const WelcomeScreen();
                  }), (route) => false)
                }
            }));

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: DoubleBackToCloseApp(
          snackBar: const SnackBar(
            content: Text("Tap back again to exit app"),
          ),
          child: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Products',
              backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_shopping_cart),
              label: 'Basket',
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: 'Profile',
              backgroundColor: Colors.pink,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
