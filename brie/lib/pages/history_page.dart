import 'dart:async';

import 'package:brie/models.dart';
import 'package:brie/pages/utils.dart';
import 'package:brie/providers.dart';
import 'package:brie/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:brie/api.dart';
import 'package:url_launcher/url_launcher.dart';

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
    final settings = ref.watch(settingsProvider).value;

    return requestHistory.isEmpty
        ? Center(child: Text('No previous history found'))
        : ListView.builder(
            itemCount: requestHistory.length,
            itemBuilder: (context, index) {
              final request = requestHistory[index];
              final mamUrl = 'https://www.myanonamouse.net/t/${request.mamBookId}';

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text('${request.book} by ${request.author}'),
                  ),
                  subtitle: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      makeText('Status: ${request.status.truncate(20)}'),
                      makeText(
                          'Download location: ${settings?.completeFolder}/${request.category}'),
                      makeText('Added: ${timeago.format(request.createdAt)}'),
                      TextButton(
                        onPressed: () async {
                          final url = Uri.parse(mamUrl);
                          if (!await launchUrl(url)) {
                            print('Could not launch $url');
                          }
                        },
                        child: Text(mamUrl),
                      )
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () async {
                          try {
                            await api.historyApi
                                .retryBookRequest(request.id.toString());
                          } catch (e) {
                            if (!context.mounted) return;
                            showErrorDialog(
                              context,
                              'Error retrying',
                              '',
                              e.toString(),
                            );
                          }
                        },
                        icon: Icon(Icons.refresh),
                        tooltip: 'Retry download',
                      ),
                      IconButton(
                        onPressed: () async {
                          try {
                            // todo add delete endpoint
                            // await api.historyApi.retryBookRequest(request.id.toString());
                            print('Unimplemented');
                          } catch (e) {
                            if (!context.mounted) return;
                            showErrorDialog(
                              context,
                              'Error retrying',
                              '',
                              e.toString(),
                            );
                          }
                        },
                        icon: Icon(Icons.delete),
                        tooltip: 'Delete from history',
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}

Widget makeText(String input) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(input),
    );
