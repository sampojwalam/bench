import 'package:flutter/material.dart';

class AddWorkoutCard extends StatelessWidget {
  const AddWorkoutCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.white60,
      child: Container(
        height: 80,
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Center(
            child: TextButton.icon(
              onPressed: null,
              icon: Icon(Icons.add),
              label: Text("Add Workout"),
            ),
          ),
        ),
      ),
    );
  }
}
