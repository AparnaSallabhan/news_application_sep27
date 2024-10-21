// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class ApplicationLogo extends StatelessWidget {
  const ApplicationLogo({
    this.smallSize = false,
    super.key,
  });
  final bool smallSize;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "News",
          style: TextStyle(
              fontSize: smallSize ? 30 : 40,
              fontWeight: FontWeight.bold,
              color: Color(0xff001F3F)),
        ),
        Text(
          "Sphere",
          style: TextStyle(
              fontSize: smallSize ? 30 : 40,
              fontWeight: FontWeight.bold,
              color: Color(0xff3A6D8C)),
        )
      ],
    );
  }
}
