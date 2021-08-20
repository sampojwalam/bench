import 'package:flutter/material.dart';

import 'package:rive/rive.dart';
import 'package:flutter/src/painting/gradient.dart' as Gradient;

class WorkoutCard extends StatelessWidget {
  final String workoutName;
  const WorkoutCard({Key key, this.workoutName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: Colors.white60,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        height: 80,
        width: 250,
        decoration: BoxDecoration(
          color: Colors.grey[600],
          gradient: Gradient.LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.amber.shade300,
              Colors.red.shade400,
            ],
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Text(workoutName),
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    child: RiveAnimation.asset(
                      'assets/animations/play_button.riv',
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Start Workout",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
