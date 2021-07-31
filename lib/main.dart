import 'package:bench/screens/chart_screen.dart';
import 'package:bench/screens/glass_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import './screens/home_screen.dart';
import './screens/splash_screen.dart';
import './screens/welcome_screen.dart';
import './screens/login_screen.dart';
import './screens/signup_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'b e n c h .',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            print(snapshot.error);
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            final _auth = FirebaseAuth.instance;

            if (_auth.currentUser != null) {
              return HomeScreen();
            } else {
              return WelcomeScreen();
            }
            // return StreamBuilder(
            //   stream: _auth.authStateChanges(),
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       //token found
            //       //HttpOverrides.global = new MyHttpOverrides();
            //       final user = _auth.currentUser;
            //       // if (user.emailVerified) {
            //       //   return ClassesScreen();
            //       // } else {
            //       //   return VerifyEmailScreen();
            //       // }
            //       return HomeScreen();
            //     }
            //     return WelcomeScreen();
            //   },
            // );
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return Container();
        },
      ),
      routes: {
        HomeScreen.routeName: (ctx) => HomeScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        SignupScreen.routeName: (ctx) => SignupScreen(),
        WelcomeScreen.routeName: (ctx) => WelcomeScreen(),
        GlassScreen.routeName: (ctx) => GlassScreen(),
        ChartScreen.routeName: (ctx) => ChartScreen(),
      },
    );
  }
}
