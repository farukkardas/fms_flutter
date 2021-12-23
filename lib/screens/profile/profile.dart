import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fms_flutter/components/button_widget.dart';
import 'package:fms_flutter/components/numbers_widget.dart';
import 'package:fms_flutter/components/profile_widget.dart';
import 'package:fms_flutter/constants/cities.dart';
import 'package:fms_flutter/models/user/user_detail.dart';
import 'package:fms_flutter/screens/homepage/homepage.dart';
import 'package:fms_flutter/screens/welcome/welcome_screen.dart';
import 'package:fms_flutter/services/auth_service.dart';
import 'package:fms_flutter/services/user_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? responseValue;
  UserDetail userDetail = UserDetail();

  @override
  void initState() {
    super.initState();
    getUserDetail();
  }

  Future<void> getUserDetail() async {
    var value = await UserService().getUserDetails();

    setState(() {
      if (value != null) {
        userDetail = value;
      }
    });
  }

  Widget userDetailLabel({text = String}) {
    return Material(
      elevation: 4,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: TextField(
        decoration: InputDecoration(
            hintText: text,
            hintStyle: const TextStyle(
                letterSpacing: 2,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var cityName = Cities.cities[userDetail.city ?? 0];

    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(
            height: 40,
          ),
          ProfileWidget(
            imagePath:
                "https://www.wpdurum.com/uploads/thumbs/en-iyi-erkek-profil-resimleri.jpg",
            onClicked: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Text("") //EditProfilePage()),
                  ));
            },
          ),
          const SizedBox(height: 24),
          buildName(userDetail),
          const SizedBox(height: 24),
          Center(child: buildUpgradeButton()),
          const SizedBox(height: 24),
          NumbersWidget(
              cityName,
              userDetail.district,
              userDetail.role?.replaceFirst(
                  userDetail.role![0], userDetail.role![0].toUpperCase())),
          const SizedBox(height: 48),
          buildAbout(userDetail),
        ],
      ),
    );
  }

  Widget buildName(UserDetail userDetail) => Column(
        children: [
          Text(
            userDetail.firstName ?? " ",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            userDetail.email ?? " ",
            style: const TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildUpgradeButton() => ButtonWidget(
        color: Colors.lightBlueAccent,
        text: 'Go to shopping!',
        onClicked: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const Homepage();
          }));
        },
      );

  Widget buildAbout(UserDetail userDetail) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Full Address',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width,
              child: Text(
                userDetail.address ?? " ",
                style: const TextStyle(fontSize: 16, height: 1.4),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: ButtonWidget(
                  color: Colors.red,
                  text: "Log out",
                  onClicked: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: Text("Do you want to logout?"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => {
                                    Navigator.pop(context, 'OK'),
                                    AuthService().logout(),
                                    Navigator.pushAndRemoveUntil(context,
                                        MaterialPageRoute(builder: (context) {
                                      return const WelcomeScreen();
                                    }), (route) => false)
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ));
                  }),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      );
}
