import 'package:bench/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import './login_screen.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup-screen';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  String _userFullName;
  String _userEmail;
  String _username;
  String _password;

  Future<void> _trySubmit(BuildContext context) async {
    print("try submit called!");
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus(); //Close keyboard

    if (isValid) {
      _formKey.currentState.save();

      final email = _userEmail.trim();
      final password = _password;
      final username = _username.trim();
      final name = _userFullName.trim();

      _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      });

      // await _auth
      //     .createUserWithEmailAndPassword(
      //   email: email,
      //   password: password,
      // )
      //     .then((value) async {
      //   // final user = FirebaseAuth.instance.currentUser;

      //   // await FirebaseFirestore.instance.collection('users').add({
      //   //   "uid": user.uid,
      //   //   "createdAt": Timestamp.now(),
      //   //   "username": username,
      //   //   "name": name,
      //   //   "email": email,
      //   // });
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 80,
            ),
            Container(
              child: Center(
                child: Text(
                  "nice to meet\nyou",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 42,
                    fontStyle: FontStyle.normal,
                    color: Color(0xFF77B6FF),
                    letterSpacing: 8,
                    height: 1.5,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: Column(
                  children: [
                    TextFormField(
                      key: ValueKey("full name"),
                      autocorrect: false,
                      textCapitalization: TextCapitalization.words,
                      enableSuggestions: false,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your name!';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'full name',
                        fillColor: Color(0xFFE5E5E5),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Color(0xFFBEDCFF),
                            width: 3.0,
                          ),
                        ),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onChanged: (value) {
                        _userFullName = value;
                      },
                      onSaved: (newValue) {
                        _userFullName = newValue;
                      },
                    ),
                    SizedBox(height: 10),
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
                        fillColor: Color(0xFFE5E5E5),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Color(0xFFBEDCFF),
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
                      key: ValueKey("username"),
                      autocorrect: false,
                      textCapitalization: TextCapitalization.words,
                      enableSuggestions: false,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your name!';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'username',
                        fillColor: Color(0xFFE5E5E5),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Color(0xFFBEDCFF),
                            width: 3.0,
                          ),
                        ),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onChanged: (value) {
                        _username = value;
                      },
                      onSaved: (newValue) {
                        _username = newValue;
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
                        suffixIcon: IconButton(
                            onPressed: null, icon: Icon(Icons.remove_red_eye)),
                        fillColor: Color(0xFFE5E5E5),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Color(0xFFBEDCFF),
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
                          await _trySubmit(context);
                        },
                        child: Text(
                          "Sign Up",
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
            SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45.0),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                      thickness: 2,
                    ),
                  ),
                  Text(
                    "  or  ",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      color: Colors.black,
                      letterSpacing: 2,
                      height: 1,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                      thickness: 2,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sign up with",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    color: Colors.black,
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
                    color: Color(0xFFBEDCFF),
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
                    color: Color(0xFFBEDCFF),
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
                    color: Color(0xFFBEDCFF),
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
                        .pushReplacementNamed(LoginScreen.routeName);
                  },
                  child: Text(
                    "Already have an account?",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 16,
                      letterSpacing: 1.5,
                      color: Colors.black,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(LoginScreen.routeName);
                  },
                  child: Text(
                    "Sign in.",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
