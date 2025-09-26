import 'package:flutter/material.dart';

class NavModel {
  const NavModel({
    required this.iconData,
    required this.label,
    required this.page,
    this.selectedIconData,
    this.iconSize,
  });

  final Widget page;
  final IconData iconData;
  final IconData? selectedIconData;
  final String label;
  final double? iconSize;
}
