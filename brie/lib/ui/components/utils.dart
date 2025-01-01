import 'package:flutter/material.dart';

void showErrorDialog(
  BuildContext context,
  String title,
  String message,
  String errorMessage,
) {
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
            ),
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
  String input,
  TextEditingController controller, {
  void Function()? editingController,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20),
    child: SizedBox(
      // width: maxSettingsWidth,
      child: TextField(
        controller: controller,
        onEditingComplete: editingController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: input,
        ),
      ),
    ),
  );
}

Widget createDropDown(
  List<String> options,
  TextEditingController controller,
  String label,
) {
  final selectedIndex = options.indexOf(controller.text);

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
      children: [
        Text(label),
        SizedBox(width: 20),
        DropdownMenu<String>(
          initialSelection: options[selectedIndex == -1 ? 0 : selectedIndex],
          onSelected: (String? value) =>
              controller.text = value ?? options.first,
          dropdownMenuEntries:
              options.map<DropdownMenuEntry<String>>((String value) {
            return DropdownMenuEntry<String>(
              value: value,
              label: value,
            );
          }).toList(),
        ),
      ],
    ),
  );
}

Widget createUpdateButtons2(
  String input,
  TextEditingController controller, {
  void Function()? editingController,
  String hintText = '',
  List<String> autofillHints = const [],
}) {
  return SizedBox(
    child: TextField(
      autofillHints: autofillHints,
      controller: controller,
      onEditingComplete: editingController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: input,
        hintText: hintText,
      ),
    ),
  );
}

Widget createDropDown2(
  List<String> options,
  ValueNotifier<String> controller,
  String hintText,
) {
  final selectedIndex = options.indexOf(controller.value);

  return DropdownMenu<String>(
    label: Text(hintText),
    requestFocusOnTap: false,
    // disable text editing
    initialSelection: options[selectedIndex == -1 ? 0 : selectedIndex],
    onSelected: (String? value) => controller.value = value ?? options.first,
    dropdownMenuEntries: options.map<DropdownMenuEntry<String>>((String value) {
      return DropdownMenuEntry<String>(
        value: value,
        label: value,
      );
    }).toList(),
  );
}
