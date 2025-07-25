import 'package:brie/clients/category_api.dart';
import 'package:brie/gen/category/v1/category.pb.dart';
import 'package:brie/providers.dart';
import 'package:brie/ui/shared/error_dialog.dart';
import 'package:brie/ui/shared/page_header.dart';
import 'package:brie/utils.dart';
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
        spacing: 10,
        children: [
          Row(
            children: [
              Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: pageHeaderBuilder(
                  header: "Category",
                  subHeading: 'Each category is the root folder for your media',
                ),
              ),
              Expanded(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 400,
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
                              if (addCategories.text.isEmpty) {
                                throw ('Empty category');
                              }

                              await ref
                                  .watch(catProvider)
                                  .addCategory(addCategories.text.trim());
                              addCategories.clear();
                            } catch (e) {
                              logger.e(
                                'An  error occurred while adding category',
                                error: e,
                              );
                              if (!context.mounted) return;
                              showErrorDialog(
                                context,
                                'Error adding category',
                                e.toString(),
                              );
                            }
                            ref.invalidate(categoryListProvider);
                          },
                          child: Text('Add'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          CategoriesView(data),
        ],
      ),
      error: (error, stackTrace) => Center(
        child: Column(
          children: [
            Text('Error', style: TextStyle(fontSize: 30)),
            Text(error.toString()),
          ],
        ),
      ),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}

class CategoriesView extends ConsumerWidget {
  const CategoriesView(this.categories, {super.key});

  final List<Category> categories;

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
            final cat = categories[index];

            return SizedBox(
              width: 300,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Card(
                  key: ValueKey(cat.category),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(cat.category),
                        Padding(
                          padding: EdgeInsets.only(right: 40),
                          child: Text(
                            downloadPath == null
                                ? ""
                                : 'Complete path:  $downloadPath/${cat.category}',
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        await ref.watch(catProvider).deleteCategory(cat);
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
