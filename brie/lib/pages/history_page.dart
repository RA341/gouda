import 'dart:async';

import 'package:brie/models.dart';
import 'package:brie/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryPage extends ConsumerStatefulWidget {
  const HistoryPage({super.key});

  @override
  ConsumerState createState() => _HistoryPageState();
}

class _HistoryPageState extends ConsumerState<HistoryPage> {
  Timer? timer;

  @override
  void initState() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        ref.invalidate(requestHistoryProvider);
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final history = ref.watch(requestHistoryProvider);

    return history.when(
      data: (data) => HistoryView(requestHistory: history.value ?? []),
      error: (error, st) => Center(
        child: Column(
          children: [
            Text('Unable to get request history'),
            Text(error.toString()),
            Text(st.toString())
          ],
        ),
      ),
      loading: () => history.value != null
          ? Center(child: CircularProgressIndicator())
          : HistoryView(requestHistory: history.value ?? []),
    );
  }
}

class HistoryView extends ConsumerWidget {
  const HistoryView({
    required this.requestHistory,
    super.key,
  });

  final List<Book> requestHistory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return requestHistory.isEmpty
        ? Center(child: Text('No previous history found'))
        : ListView.builder(
            itemCount: requestHistory.length,
            itemBuilder: (context, index) {
              final request = requestHistory[index];

              return ListTile(
                title: Text(request.book),
                subtitle: Text(request.status),
              );
            },
          );
  }
}
