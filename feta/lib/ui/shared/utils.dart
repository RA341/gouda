import 'package:flutter/material.dart';

Widget createUpdateButtons(
  TextEditingController controller, {
  String label = '',
  void Function(String)? onChanged,
  void Function()? editingController,
  String hintText = '',
  List<String> autofillHints = const [],
  bool enabled = true,
  bool obscureText = false,
}) {
  return TextField(
    enabled: enabled,
    autofillHints: autofillHints,
    controller: controller,
    onEditingComplete: editingController,
    onChanged: onChanged,
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      labelText: label,
      hintText: hintText,
    ),
    obscureText: obscureText,
  );
}

Widget createDropDown(
  List<String> options,
  TextEditingController controller,
  String hintText, {
  required String Function(String p0) onChanged,
}) {
  final selectedIndex = options.indexOf(controller.text);
  if (controller.text.isEmpty) {
    controller.text = options.first;
  }
  onChanged(controller.text);

  return DropdownMenu<String>(
    label: Text(hintText),
    requestFocusOnTap: false,
    // disable text editing
    initialSelection: options[selectedIndex == -1 ? 0 : selectedIndex],
    onSelected: (String? value) {
      controller.text = value ?? options.first;
      onChanged(controller.text);
    },
    dropdownMenuEntries: options.map<DropdownMenuEntry<String>>((String value) {
      return DropdownMenuEntry<String>(
        value: value,
        label: value,
      );
    }).toList(),
  );
}
