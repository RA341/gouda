import 'package:flutter/cupertino.dart';

class SettingsPageConfig {
  SettingsPageConfig({
    required this.title,
    required this.iconData,

    required this.child,
    this.buttons = const [],
  });

  final String title;
  final IconData iconData;

  final Widget child;
  final List<Widget> buttons;
}
