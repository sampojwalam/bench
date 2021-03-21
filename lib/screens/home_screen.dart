import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './welcome_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User _user;
  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.of(context).pushReplacementNamed(WelcomeScreen.routeName);
    } else {
      _user = FirebaseAuth.instance.currentUser;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("b e n c h ."),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFFAB55FF),
                Color(0xFF375FEA),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("Enjoy this picture of teddy :)"),
                SizedBox(height: 10),
                Image.asset("assets/images/teddy.png"),
                SizedBox(height: 10),
                Text("Signed in as ${_user.email}"),
                Text("Internal uid: ${_user.uid}"),
                ElevatedButton.icon(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context)
                        .pushReplacementNamed(WelcomeScreen.routeName);
                  },
                  icon: Icon(Icons.exit_to_app),
                  label: Text("log out"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
