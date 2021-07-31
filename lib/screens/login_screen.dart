import 'dart:ui';

import 'package:bench/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import './signup_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  String _userEmail;
  String _password;

  Future<void> _trySubmit() async {
    final isValid = _formKey.currentState.validate();

    if (isValid) {
      _formKey.currentState.save();

      final email = _userEmail.trim();
      final password = _password;

      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) async {
          // final user = FirebaseAuth.instance.currentUser;
          // await FirebaseFirestore.instance.collection('users').add({
          //   "uid": user.uid,
          //   "createdAt": Timestamp.now(),
          //   "username": username,
          //   "name": name,
          //   "email": email,
          // });
        });
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/images/gradient.png",
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Container(
                child: Center(
                  child: Text(
                    "good to see\nyou again",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 42,
                      fontStyle: FontStyle.normal,
                      color: Colors.white,
                      letterSpacing: 8,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
              Spacer(),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45),
                  child: Column(
                    children: [
                      TextFormField(
                        key: ValueKey("email"),
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        enableSuggestions: false,
                        validator: (value) {
                          if (value.isEmpty || !value.contains('@')) {
                            return 'Please enter a valid email address';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'email',
                          fillColor: Color(0x33E5E5E5),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 3.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 3.0,
                            ),
                          ),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (value) {
                          _userEmail = value;
                        },
                        onSaved: (newValue) {
                          _userEmail = newValue;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        key: ValueKey("password"),
                        autocorrect: false,
                        textCapitalization: TextCapitalization.words,
                        enableSuggestions: false,
                        validator: (value) {
                          if (value.isEmpty || value.length < 7) {
                            return 'Password must be at least 7 characters long!';
                          } else {
                            return null;
                          }
                        },
                        obscureText: true,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: 'password',
                          fillColor: Color(0x33E5E5E5),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 3.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 3.0,
                            ),
                          ),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (value) {
                          _password = value;
                        },
                        onSaved: (newValue) {
                          _password = newValue;
                        },
                      ),
                      SizedBox(height: 20),
                      ConstrainedBox(
                        constraints:
                            BoxConstraints.tightFor(height: 50, width: 275),
                        child: ElevatedButton(
                          onPressed: () async {
                            await _trySubmit();
                            final _auth = FirebaseAuth.instance;
                            if (_auth.currentUser != null) {
                              Navigator.of(context)
                                  .pushReplacementNamed(HomeScreen.routeName);
                            }
                          },
                          child: Text(
                            "Log In",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontFamily: "Poppins",
                              letterSpacing: 6,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFFBEDCFF),
                            textStyle: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontFamily: "Poppins",
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.white,
                        thickness: 2,
                      ),
                    ),
                    Text(
                      "  or  ",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 20,
                        fontStyle: FontStyle.normal,
                        color: Colors.white,
                        letterSpacing: 2,
                        height: 1,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.white,
                        thickness: 2,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Log in with",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      color: Colors.white,
                      letterSpacing: 2,
                      height: 1,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: IconButton(
                        onPressed: () {
                          print("Sign in with google!");
                        },
                        icon: Image.asset("assets/icons/google_logo.png"),
                      ),
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: IconButton(
                        onPressed: () {
                          print("Sign in with facebook!");
                        },
                        icon: Image.asset("assets/icons/facebook_logo.png"),
                      ),
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: IconButton(
                        onPressed: () {
                          print("Sign in with apple!");
                        },
                        icon: Image.asset("assets/icons/apple_logo.png"),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(SignupScreen.routeName);
                    },
                    child: Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        letterSpacing: 1.5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(SignupScreen.routeName);
                    },
                    child: Text(
                      "Sign up.",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
