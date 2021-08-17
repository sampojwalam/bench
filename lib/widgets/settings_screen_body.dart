import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rive/rive.dart';

import '../screens/chart_screen.dart';
import '../screens/glass_screen.dart';
import '../screens/welcome_screen.dart';

class SettingsScreenBody extends StatelessWidget {
  SettingsScreenBody({Key key}) : super(key: key);
  User _user;
  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.of(context).pushReplacementNamed(WelcomeScreen.routeName);
    } else {
      _user = FirebaseAuth.instance.currentUser;
    }
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
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
              ),
              SizedBox(height: 10),
              Text("Holy mother of animations!!! 🎉"),
              Container(
                height: 300,
                width: 300,
                child: RiveAnimation.asset(
                  'assets/animations/messeger_icon.riv',
                ),
              ),
              SizedBox(height: 10),
              Text("\"Anotha one\" - DJ Khaled"),
              Container(
                height: 300,
                width: 300,
                child: RiveAnimation.asset(
                  'assets/animations/ball_box.riv',
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(ChartScreen.routeName);
                },
                child: Text("Charts 😩😩😩"),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(GlassScreen.routeName);
                },
                child: Text("Glassmorphic blurs 😤😤😤"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
