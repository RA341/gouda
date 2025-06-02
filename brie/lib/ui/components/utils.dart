import 'package:flutter/material.dart';

void showErrorDialog(
  BuildContext context,
  String title,
  String message, {
  String errorMessage = "",
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (errorMessage.isNotEmpty)
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    'The following was the error message',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    child: SelectableText(
                      errorMessage,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              )
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

Widget createUpdateButtons(
  TextEditingController controller, {
  String input = '',
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
      labelText: input,
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
