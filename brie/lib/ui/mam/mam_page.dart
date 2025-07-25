import 'package:brie/clients/mam_api.dart';
import 'package:brie/ui/mam/search_bar.dart';
import 'package:brie/ui/mam/search_result.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MamPage extends ConsumerStatefulWidget {
  const MamPage({super.key});

  @override
  ConsumerState<MamPage> createState() => _MamPageState();
}

class _MamPageState extends ConsumerState<MamPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            MamSearchBar(),
            SizedBox(height: 20),
            SearchResultDisplay(),
          ],
        ),
      ),
    );
  }
}

class SearchPaginator extends ConsumerWidget {
  const SearchPaginator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(mamBooksSearchNotifier.notifier);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Previous Button
          ElevatedButton.icon(
            onPressed: notifier.page > 0 ? notifier.paginateBack : null,
            icon: const Icon(Icons.arrow_back),
            label: const Text('Previous'),
          ),

          // Page Info
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Page ${notifier.page + 1}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${notifier.found} of ${notifier.total} items',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),

          // Next Button
          ElevatedButton.icon(
            onPressed: !notifier.lastPage() ? notifier.paginateForward : null,
            icon: const Icon(Icons.arrow_forward),
            label: const Text('Next'),
          ),
        ],
      ),
    );
  }
}

class SearchResultDisplay extends ConsumerWidget {
  const SearchResultDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booksAsync = ref.watch(mamBooksSearchNotifier);

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: booksAsync.when(
          loading: () {
            return const Center(child: CircularProgressIndicator());
          },
          data: (books) {
            if (books.isEmpty) {
              return const Center(
                child: Text(
                  'No books found',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              );
            }

            return Column(
              children: [
                Expanded(
                  // This allows ListView to take available space
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: books.length,
                    itemBuilder: (context, index) =>
                        BookItem(book: books[index]),
                  ),
                ),
                const SizedBox(height: 10),
                const SearchPaginator(),
              ],
            );
          },
          error: (error, stackTrace) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    'Error: $error',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
