import 'dart:ui';

import 'package:bench/widgets/add_workout_card.dart';
import 'package:bench/widgets/workout_card.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';

import '../screens/chart_screen.dart';
import '../screens/glass_screen.dart';
import '../screens/welcome_screen.dart';

class HomeScreenBody extends StatelessWidget {
  HomeScreenBody({Key key}) : super(key: key);
  User _user;
  final workoutNames = [
    "Push",
    "Pull",
    "Legs",
  ];
  @override
  Widget build(BuildContext context) {
    int _cardCount = 4;
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.of(context).pushReplacementNamed(WelcomeScreen.routeName);
    } else {
      _user = FirebaseAuth.instance.currentUser;
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              height: 150,
              child: ListView.builder(
                  itemCount: _cardCount,
                  shrinkWrap: false,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    int maxIndex = _cardCount - 1;
                    if (index != maxIndex) {
                      return WorkoutCard(
                        workoutName: workoutNames[index],
                      );
                    } else {
                      return AddWorkoutCard();
                    }
                  }),
            ),
            Text("Enjoy this picture of teddy x 2 baby :)"),
            SizedBox(height: 10),
            Image.asset("assets/images/teddy.png"),
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
    );
  }
}
