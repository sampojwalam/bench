import 'dart:ui';

import 'package:flutter/material.dart';

class GlassScreenBody extends StatelessWidget {
  const GlassScreenBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "assets/images/bg.png",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 16.0,
              sigmaY: 16.0,
            ),
            child: Container(
              height: 400,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
