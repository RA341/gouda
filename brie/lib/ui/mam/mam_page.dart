import 'package:brie/clients/mam_api.dart';
import 'package:brie/gen/mam/v1/mam.pb.dart';
import 'package:brie/ui/mam/search_bar.dart';
import 'package:brie/ui/mam/search_book_result.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;

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
            UserDataView(),
            SizedBox(height: 10),
            MamSearchBar(),
            SizedBox(height: 20),
            SearchResultDisplay(),
          ],
        ),
      ),
    );
  }
}

class UserDataView extends ConsumerWidget {
  const UserDataView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(mamProfileProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
      child: profile.when(
        data: (data) => _buildCompactProfile(context, data),
        error: (error, stackTrace) => Text(
          'Unable to get userdata: $error',
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
        loading: () => const Row(
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            SizedBox(width: 8),
            Text('Loading...'),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactProfile(BuildContext context, UserData data) {
    return Row(
      children: [
        // Username with class
        Expanded(
          flex: 2,
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                TextSpan(
                  text: data.username,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                if (data.classname.isNotEmpty) ...[
                  const TextSpan(text: ' ('),
                  TextSpan(
                    text: data.classname,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const TextSpan(text: ')'),
                ],
              ],
            ),
          ),
        ),

        const SizedBox(width: 12),

        // Bonus
        Text(
          'Bonus: ${data.seedbonus}',
          style: Theme.of(context).textTheme.bodySmall,
        ),

        const SizedBox(width: 12),

        // Ratio
        Text(
          'Ratio: ${data.ratio.toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.bodySmall,
        ),

        const SizedBox(width: 12),

        // VIP expiration
        if (data.vipUntil.isNotEmpty)
          Expanded(
            flex: 2,
            child: Text(
              _formatVipExpiration(data.vipUntil),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
    );
  }

  String _formatVipExpiration(String vipUntil) {
    try {
      final vipDate = DateTime.parse(vipUntil);
      final now = DateTime.now();
      final formatted = timeago.format(vipDate, allowFromNow: true);

      // Format the date and time
      final dateStr =
          '${vipDate.day.toString().padLeft(2, '0')}/${vipDate.month.toString().padLeft(2, '0')}/${vipDate.year}';
      final timeStr =
          '${vipDate.hour.toString().padLeft(2, '0')}:${vipDate.minute.toString().padLeft(2, '0')}';

      // Calculate time from today
      String timeFromNow = "";
      // if (difference.isNegative) {
      //   timeFromNow = 'expired';
      // } else if (difference.inDays > 0) {
      //   timeFromNow = '${difference.inDays}d';
      // } else if (difference.inHours > 0) {
      //   timeFromNow = '${difference.inHours}h';
      // } else {
      //   timeFromNow = '${difference.inMinutes}m';
      // }

      return 'Expires $dateStr ($formatted)';
    } catch (e) {
      return 'VIP: $vipUntil';
    }
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
