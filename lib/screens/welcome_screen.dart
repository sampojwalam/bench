import 'package:bench/screens/login_screen.dart';
import 'package:bench/screens/signup_screen.dart';
import 'package:flutter/material.dart';

import './home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color(0xFFAB55FF),
              Color(0xFF375FEA),
            ],
          ),
        ),
        height: size.height,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: 200),
            Container(
              width: 200,
              child: Image.asset("assets/images/bench_logo.png"),
            ),
            SizedBox(height: 50),
            Container(
              width: 200,
              child: Image.asset("assets/images/weightlifting.png"),
            ),
            SizedBox(height: 100),
            Container(
              width: size.width * 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(29),
                child: FlatButton(
                  onPressed: () {
                    print("works!");
                    Navigator.of(context).pushNamed(LoginScreen.routeName);
                  },
                  child: Text(
                    "LOGIN",
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  color: Colors.white,
                  textColor: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: size.width * 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(29),
                child: FlatButton(
                  onPressed: () {
                    print("works!");
                    Navigator.of(context).pushNamed(SignupScreen.routeName);
                  },
                  child: Text(
                    "SIGN UP",
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  color: Colors.white,
                  textColor: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
