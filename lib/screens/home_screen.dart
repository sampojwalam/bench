import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:bench/screens/chart_screen.dart';
import 'package:bench/screens/glass_screen.dart';
import 'package:bench/widgets/chart_screen_body.dart';
import 'package:bench/widgets/glass_screen_body.dart';
import 'package:bench/widgets/home_screen_body.dart';
import 'package:bench/widgets/settings_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import './welcome_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _pageIndex = 2;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
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
      bottomNavigationBar: Container(
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
        child: CurvedNavigationBar(
          key: _bottomNavigationKey,
          items: [
            Icon(Icons.list),
            Icon(Icons.calendar_today),
            Icon(Icons.directions_run),
            Icon(Icons.settings),
            Icon(Icons.exit_to_app),
          ],
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Colors.white,
          color: Colors.transparent,
          index: _pageIndex,
          onTap: (index) {
            if (index == 4) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 16.0,
                        sigmaY: 16.0,
                      ),
                      child: AlertDialog(
                        title: Text(
                          "Log Out?",
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        actionsAlignment: MainAxisAlignment.spaceBetween,
                        actions: [
                          TextButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                              // setState(() {
                              //   index = _pageIndex;
                              // });
                            },
                            icon: Icon(Icons.cancel),
                            label: Text("Cancel"),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.of(context).pushReplacementNamed(
                                WelcomeScreen.routeName,
                              );
                            },
                            icon: Icon(Icons.exit_to_app),
                            label: Text("Log out"),
                          )
                        ],
                        backgroundColor: Colors.white,
                      ),
                    );
                  }).then((value) {
                final CurvedNavigationBarState navBarState =
                    _bottomNavigationKey.currentState;
                navBarState.setPage(_pageIndex);
              });

              print("logout pressed");
            } else {
              setState(() {
                _pageIndex = index;
              });
            }

            if (index == 0) {
              //Display Charts!
            } else if (index == 1) {
              //display Calendar Screen!
            } else if (index == 2) {
              //display Home Screen!
            } else if (index == 3) {
              //display Settings Screen!
            } else {
              //Logout
              //FirebaseAuth.instance.signOut();
              //Navigator.of(context).pushReplacementNamed(WelcomeScreen.routeName);
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: getPage(_pageIndex),
      ),
    );
  }
}

Widget getPage(int _pageIndex) {
  if (_pageIndex == 2) {
    return HomeScreenBody();
  } else if (_pageIndex == 0) {
    return ChartScreenBody();
  } else if (_pageIndex == 1) {
    return GlassScreenBody();
  } else if (_pageIndex == 3) {
    return SettingsScreenBody();
  } else {
    return Container();
  }
}
