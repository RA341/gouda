import 'package:brie/main.dart';
import 'package:brie/pages/settings_page.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: Text('Gouda'),
        actions: [
          ElevatedButton(
            onPressed: () async => await Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SettingsPage()),
            ),
            child: Text('Settings'),
          ),
          SizedBox(width: 20),
          ElevatedButton(
            onPressed: () async => await Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => CategoryPage()),
            ),
            child: Text('Categories'),
          )
        ],
      ),
      body: cats.when(
        data: (data) => Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 200),
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
                        await api.categoryApi
                            .addCategory(addCategories.text.trim());
                        ref.invalidate(categoryListProvider);
                      },
                      child: Text('Add'),
                    ),
                  )
                ],
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
      ),
    );
  }
}

class CategoriesView extends ConsumerWidget {
  const CategoriesView(this.categories, {super.key});

  final List<String> categories;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 120),
        child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return Card(
              key: ValueKey(categories[index]),
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: ListTile(
                title: Text(categories[index]),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    await api.categoryApi.deleteCategory(categories[index]);
                    ref.invalidate(categoryListProvider);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
