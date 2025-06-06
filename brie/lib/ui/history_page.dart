import 'dart:async';

import 'package:brie/clients/history_api.dart';
import 'package:brie/gen/media_requests/v1/media_requests.pb.dart';
import 'package:brie/providers.dart';
import 'package:brie/ui/components/page_header.dart';
import 'package:brie/ui/components/utils.dart';
import 'package:brie/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

class HistoryPage extends HookConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      spacing: 10,
      children: [
        Row(
          children: [
            Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: pageHeaderBuilder(
                header: "Media",
                subHeading: "List of media downloaded by gouda",
              ),
            ),
            Expanded(child: Center(child: MediaSearchBar())),
          ],
        ),
        Expanded(child: ResultViewPage()),
      ],
    );
  }
}

class MediaSearchBar extends HookConsumerWidget {
  const MediaSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final search = useTextEditingController();

    return SearchBar(
      controller: search,
      hintText: 'Search media',
      onSubmitted: (value) async {
        ref.read(searchProvider.notifier).state = value;
        ref.read(requestHistoryProvider.notifier).fetchData();
      },
      trailing: [
        IconButton(
          onPressed: () {
            ref.read(searchProvider.notifier).state = search.text;
            ref.read(requestHistoryProvider.notifier).fetchData();
          },
          icon: Icon(Icons.search),
        ),
        ref.watch(searchProvider).isNotEmpty
            ? IconButton(
                onPressed: () {
                  search.clear();
                  ref.invalidate(searchProvider);
                  ref.read(requestHistoryProvider.notifier).fetchData();
                },
                icon: Icon(Icons.clear),
              )
            : SizedBox(),
      ],
    );
  }
}

class ResultViewPage extends ConsumerStatefulWidget {
  const ResultViewPage({super.key});

  @override
  ConsumerState createState() => _ResultViewPageState();
}

class _ResultViewPageState extends ConsumerState<ResultViewPage> {
  Timer? timer;

  @override
  void initState() {
    timer = createTimer();
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Timer createTimer() {
    return Timer.periodic(
      const Duration(seconds: 1),
      (_) async {
        ref.read(requestHistoryProvider.notifier).fetchData();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final history = ref.watch(requestHistoryProvider);

    return history.when(
      data: (data) => HistoryView(requestHistory: history.value ?? []),
      error: (error, st) {
        timer?.cancel();
        return Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                'Unable to get request history',
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(height: 20),
              Text(error.toString()),
              Text(st.toString()),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  timer = createTimer();
                },
                child: Text(
                  'Retry',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        );
      },
      loading: () => HistoryView(requestHistory: history.value ?? []),
    );
  }
}

class HistoryView extends HookConsumerWidget {
  const HistoryView({
    required this.requestHistory,
    super.key,
  });

  final List<Media> requestHistory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider).value;

    return requestHistory.isEmpty
        ? Center(child: Text('No previous history found'))
        : Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: requestHistory.length,
                  itemBuilder: (context, index) {
                    final request = requestHistory[index];
                    final mamUrl =
                        'https://www.myanonamouse.net/t/${request.mamBookId}';

                    final seriesStr = (request.series.isEmpty ||
                            request.seriesNumber == 0)
                        ? 'from Series:${request.series} #${request.seriesNumber}'
                        : '';

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                              '${request.book} by ${request.author} $seriesStr'),
                        ),
                        subtitle: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'Status: ${request.status.truncate(20)}',
                                style: TextStyle(
                                  color:
                                      statusColor(request.status.toLowerCase()),
                                ),
                              ),
                            ),
                            makeText(
                                'Download location: ${settings?.completeFolder}/${request.category}'),
                            makeText(
                                'Added: ${timeago.format(DateTime.parse(request.createdAt))}'),
                            TextButton(
                              onPressed: () async {
                                try {
                                  final url = Uri.parse(mamUrl);
                                  if (!await launchUrl(url)) {
                                    logger.e('Could not launch $url');
                                  }
                                } catch (e) {
                                  logger.e('Could not go launch url', error: e);
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
                                  await ref
                                      .watch(historyApiProvider)
                                      .retryBookRequest(request.iD);
                                } catch (e) {
                                  if (!context.mounted) return;
                                  showErrorDialog(
                                    context,
                                    'Error retrying',
                                    '',
                                    errorMessage: e.toString(),
                                  );
                                }
                              },
                              icon: Icon(Icons.refresh),
                              tooltip: 'Retry download',
                            ),
                            IconButton(
                              onPressed: () async {
                                try {
                                  await ref
                                      .watch(historyApiProvider)
                                      .deleteBookRequest(request.iD);
                                  ref.invalidate(requestHistoryProvider);
                                } catch (e) {
                                  if (!context.mounted) return;
                                  showErrorDialog(
                                    context,
                                    'Error retrying',
                                    '',
                                    errorMessage: e.toString(),
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
                ),
              ),
              SizedBox(height: 20),
              if (ref.watch(searchProvider).isEmpty) PaginationActions()
            ],
          );
  }
}

class PaginationActions extends HookConsumerWidget {
  const PaginationActions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controls = ref.read(requestHistoryProvider.notifier);
    final bookCount = ref.watch(requestHistoryProvider).value?.length ?? 0;

    final isLoading = useState(false);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
            onPressed: controls.offset == 0 || isLoading.value
                ? null
                : () async {
                    isLoading.value = true;
                    try {
                      await controls.paginateBack();
                    } catch (e) {
                      if (!context.mounted) return;
                      showErrorDialog(
                        context,
                        'Unable to get previous page',
                        '',
                        errorMessage: e.toString(),
                      );
                    }
                    isLoading.value = false;
                  },
            icon: Icon(Icons.arrow_back),
          ),
          SizedBox(width: 20),
          Text(
            'Page: ${controls.offset + 1}',
            style: getStyle(),
          ),
          SizedBox(width: 20),
          Text(
            'On this page: $bookCount',
            style: getStyle(),
          ),
          SizedBox(width: 20),
          Text(
            'Total: ${controls.totalRecords}',
            style: getStyle(),
          ),
          SizedBox(width: 20),
          IconButton(
            onPressed: controls.lastPage() || isLoading.value
                ? null
                : () async {
                    isLoading.value = true;
                    try {
                      await controls.paginateForward();
                    } catch (e) {
                      if (!context.mounted) return;
                      showErrorDialog(
                        context,
                        'Unable to get next page',
                        '',
                        errorMessage: e.toString(),
                      );
                    }
                    isLoading.value = false;
                  },
            icon: Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }

  TextStyle getStyle() => TextStyle(fontSize: 15);
}

Color? statusColor(String text) {
  if (text.toLowerCase().startsWith('complete')) {
    return null;
  } else if (text.toLowerCase().startsWith('downloading')) {
    return Colors.amberAccent;
  } else {
    return Colors.redAccent;
  }
}

Widget makeText(String input) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(input),
    );
