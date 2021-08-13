import 'package:byteinc/models/user.dart';
import 'package:byteinc/utilities/shared_preference.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  late final String _firstName;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserPreferences user = UserPreferences();

  // Future<User> userData;

  Future<User> getUserData() {
    return UserPreferences().getUser();
  }

  @override
  void initState() {
    // TODO: implement initState
    print("here");
    // Cart().itemsFromDb();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 50.0),
      child: Container(
        child: ListView(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 90,
                      child: CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                    ),
                    Text(
                      "Hi there!",
                      style: TextStyle(
                        fontSize: 17,
                        color: Color(0xff3A683B),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
