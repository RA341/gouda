import 'package:flutter/material.dart';

List<Widget> pageHeaderBuilder({
  required String header,
  required String subHeading,
}) =>
    [
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          header,
          style: TextStyle(fontSize: 40),
        ),
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: Text(subHeading),
      ),
    ];
