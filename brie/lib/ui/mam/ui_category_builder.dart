import 'package:brie/ui/mam/provider.dart';
import 'package:brie/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryDropDown extends ConsumerWidget {
  const CategoryDropDown({required this.category, super.key});

  final ValueNotifier<String> category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catListAsync = ref.watch(categoryListProvider);

    final catList = catListAsync.value;
    final isLoading = catListAsync.isLoading;
    final isEmpty = catList == null || catList.isEmpty;

    final initialSelection = isEmpty ? null : catList[0].category;

    if (initialSelection != null && category.value.isEmpty) {
      // Use addPostFrameCallback to avoid modifying state during build
      WidgetsBinding.instance.addPostFrameCallback((_) {
        category.value = initialSelection;
      });
    }

    return DropdownMenu<String>(
      label: const Text("Category"),
      requestFocusOnTap: false,
      enabled: !isLoading,
      initialSelection: initialSelection,
      onSelected: (String? value) async {
        if (value == '__add_new__') {
          await _showAddCategoryDialog(context, ref);
          return;
        }

        if (value != null) {
          logger.i("selected $value");
          category.value = value;
          return;
        }
      },
      dropdownMenuEntries: [
        // Add button as first entry
        DropdownMenuEntry<String>(
          value: '__add_new__',
          label: 'Add New Category',
          leadingIcon: Icon(
            Icons.add_circle_outline,
            color: Theme
                .of(context)
                .colorScheme
                .primary,
          ),
        ),
        // Existing categories
        if (catList != null)
          ...catList.map(
                (e) =>
                DropdownMenuEntry<String>(
                  value: e.category,
                  label: e.category,
                  trailingIcon: IconButton(
                    icon: const Icon(Icons.delete, size: 18),
                    onPressed: isLoading
                        ? null
                        : () async {
                      final error = await ref
                          .read(categoryListProvider.notifier)
                          .delete(e);

                      if (error != null && context.mounted) {
                        await _showErrorDialog(context, error);
                      }
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ),
          ),
      ],
    );
  }

  Future<void> _showAddCategoryDialog(BuildContext context,
      WidgetRef ref,) async {
    final controller = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (dialogContext) =>
          AlertDialog(
            title: const Text('Add Category'),
            content: TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Category Name',
                border: OutlineInputBorder(),
              ),
              autofocus: true,
              onSubmitted: (value) async {
                if (value.isNotEmpty) {
                  Navigator.pop(dialogContext);
                  await _addCategory(context, ref, value);
                }
              },
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () async {
                  if (controller.text.isNotEmpty) {
                    Navigator.pop(dialogContext);
                    await _addCategory(context, ref, controller.text);
                  }
                },
                child: const Text('Add'),
              ),
            ],
          ),
    );
  }

  Future<void> _addCategory(BuildContext context,
      WidgetRef ref,
      String categoryName,) async {
    final error = await ref
        .read(categoryListProvider.notifier)
        .add(categoryName);

    if (error != null && context.mounted) {
      await _showErrorDialog(context, error);
    }
  }

  Future<void> _showErrorDialog(BuildContext context, String error) async {
    await showDialog<void>(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: const Text('Error'),
            content: Text(error),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }
}
