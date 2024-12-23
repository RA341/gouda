import 'package:brie/api/category_api.dart';
import 'package:brie/ui/utils.dart';
import 'package:brie/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CategoryPage extends HookConsumerWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cats = ref.watch(categoryListProvider);
    final addCategories = useTextEditingController(text: '');

    return cats.when(
      data: (data) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 200),
            child: SizedBox(
              width: 400,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 4,
                    child: TextField(
                      controller: addCategories,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Add new category',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          await catApi.addCategory(addCategories.text.trim());
                          addCategories.clear();
                        } catch (e) {
                          print(e);
                          if (!context.mounted) return;
                          showErrorDialog(
                            context,
                            'Error adding category',
                            'You may have tried to add a category that already exists',
                            e.toString(),
                          );
                        }
                        ref.invalidate(categoryListProvider);
                      },
                      child: Text('Add'),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          CategoriesView(data),
        ],
      ),
      error: (error, stackTrace) => Center(
        child: Column(
          children: [
            Text('Error', style: TextStyle(fontSize: 30)),
            Text(error.toString())
          ],
        ),
      ),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}

class CategoriesView extends ConsumerWidget {
  const CategoriesView(this.categories, {super.key});

  final List<(String, int)> categories;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider).valueOrNull;
    final downloadPath = settings?.completeFolder;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 120),
        child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final (catName, catId) = categories[index];

            return SizedBox(
              width: 300,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Card(
                  key: ValueKey(catName),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(catName),
                        Padding(
                          padding: EdgeInsets.only(right: 40),
                          child: Text(
                            downloadPath == null
                                ? ""
                                : 'Complete path:  $downloadPath/$catName',
                            style: TextStyle(color: Colors.green),
                          ),
                        )
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        await catApi.deleteCategory(catId, catName);
                        ref.invalidate(categoryListProvider);
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
