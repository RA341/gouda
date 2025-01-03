import 'package:brie/gen/category/v1/category.pb.dart';
import 'package:brie/grpc/category_api.dart';
import 'package:brie/providers.dart';
import 'package:brie/ui/components/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:grpc/grpc.dart';
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
                          if (addCategories.text.isEmpty) {
                            throw Exception('Empty category');
                          }

                          await ref
                              .watch(catProvider)
                              .addCategory(addCategories.text.trim());
                          addCategories.clear();
                        } on GrpcError catch (e) {
                          if (!context.mounted) return;
                          showErrorDialog(
                            context,
                            'Error adding category',
                            'You may have tried to add a category that already exists',
                            e.message.toString(),
                          );
                        } catch (e) {
                          print(
                              'An  error occurred while adding category ${e.toString()}');
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
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                        )
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
