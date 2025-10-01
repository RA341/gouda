import 'package:brie/ui/home/provider.dart';
import 'package:brie/ui/shared/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final books = ref.watch(bookHistoryProvider);

    return books.when(
      data: (data) {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(data[index].book),
              subtitle: Text(data[index].status),
            );
          },
        );
      },
      error: (error, stackTrace) {
        return ErrorDisplay(message: error.toString());
      },
      loading: LoadingSpinner.new,
    );
  }
}
