import 'package:brie/clients/mam_api.dart';
import 'package:brie/clients/settings_api.dart';
import 'package:brie/gen/mam/v1/mam.pb.dart';
import 'package:brie/ui/layout/layout_page.dart';
import 'package:brie/ui/mam/mam_search.dart';
import 'package:brie/ui/mam/provider.dart';
import 'package:brie/ui/mam/ui_search_book_item.dart';
import 'package:brie/ui/settings/provider.dart';
import 'package:brie/ui/shared/error_dialog.dart';
import 'package:brie/utils.dart';
import 'package:brie/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

const errMamNotSetupUser =
    "Administrator has not setup search functionality yet";
const errMamNotSetupAdmin = "MAM setup is not complete";

final FutureProvider<String> isMamSetupProvider =
    FutureProvider.autoDispose<String>((ref) async {
      final (_, err) = await runGrpcRequest(
        () => ref.watch(mamApiProvider).isMamSetup(IsMamSetupRequest()),
      );
      if (err.isEmpty) {
        // mam is setup
        return "";
      }

      final isAdmin = await ref.watch(isAdminProvider.future);
      logger.w("Mam is not setup $err");

      return isAdmin ? errMamNotSetupAdmin : errMamNotSetupUser;
    });

class MamView extends ConsumerWidget {
  const MamView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setup = ref.watch(isMamSetupProvider);

    return setup.when(
      data: (status) =>
          status.isEmpty ? const MamCore() : MamNotSetup(status: status),
      error: (error, stackTrace) => Center(
        child: Text("Unable to check if mam is setup $mamApiProvider"),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class MamCore extends ConsumerWidget {
  const MamCore({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchProvider = ref.watch(mamBooksSearchProvider);
    final searchNotifier = ref.watch(mamBooksSearchProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SearchField(),
          Expanded(
            child: searchProvider.when(
              data: (searchResultsList) =>
                  Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Container(
                  child: searchResultsList.isEmpty
                      ? const Center(
                          child: Text("No results found"),
                        )
                      : ResultList(data: searchResultsList),
                ),
              ),
              error: (error, stackTrace) =>
                  ErrorDisplay(message: error.toString()),
              loading: LoadingSpinner.new,
            ),
          ),
          if (!isMobileView(context) && searchNotifier.total != 0)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () async =>
                      ref.read(mamBooksSearchProvider.notifier).paginateBack(),
                  icon: const Icon(Icons.chevron_left),
                ),
                Column(
                  children: [
                    Text(
                      "On this page ${searchNotifier.found}",
                    ),
                    Text(
                      "Page: ${searchNotifier.page + 1}  / ${(searchNotifier
                          .total / searchNotifier.perPage).ceil()}",
                    ),
                  ],
                ),

                IconButton(
                  onPressed: () async =>
                      ref
                          .read(mamBooksSearchProvider.notifier)
                          .paginateForward(),
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class ResultList extends HookConsumerWidget {
  const ResultList({
    required this.data,
    super.key,
  });

  final List<SearchBook> data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();

    useEffect(() {
      void onScroll() {
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent) {
          if (isMobileView(context)) {
            // todo attach paginator for mobile here
            logger.i("Scrolled to the end!");
          }
        }
      }

      scrollController.addListener(onScroll);
      return () => scrollController.removeListener(onScroll);
    });

    return ListView.builder(
      controller: scrollController,
      itemCount: data.length,
      itemBuilder: (context, index) => SearchBookItem(book: data[index]),
    );
  }
}

class SearchField extends HookConsumerWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final curQuery = ref.query();
    logger.i("query search ${curQuery.toJson()}");
    final sController = useTextEditingController(
      text: curQuery.text?.orNull,
    );
    useEffect(() {
      final queryText = curQuery.text?.orNull ?? '';
      if (sController.text != queryText) {
        sController.text = queryText;
      }
      return null;
    }, [curQuery.text]);

    final filterController = useState(false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Search',
                  ),
                  controller: sController,
                  onSubmitted: (value) async {
                    ref.updateQuery((query) => query..text = value);
                    await ref.search(
                      ref.read(mamSearchQueryProvider),
                      search: true,
                    );
                  },
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () async {
                    await ref.search(
                      ref.read(mamSearchQueryProvider),
                      search: true,
                    );
                  },
                  icon: const Icon(Icons.search),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 10,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  filterController.value = !filterController.value;
                },
                label: const Text("More Filters"),
                icon: filterController.value
                    ? const Icon(Icons.keyboard_arrow_up)
                    : const Icon(Icons.keyboard_arrow_down),
              ),
              ...MainCategory.values.map(
                    (cat) =>
                    FilterChip(
                      label: Text(capitalize(cat.name)),
                      selected: curQuery.mainCategories.contains(cat),
                      onSelected: (value) async =>
                          ref.updateQuery(
                                (query) => query..toggleCategory(cat),
                          ),
                    ),
              ),
            ],
          ),
        ),
        if (filterController.value)
          LayoutBuilder(
            builder: (context, constraints) {
              final screenHeight = MediaQuery
                  .of(context)
                  .size
                  .height;
              final height = screenHeight * 0.15;

              return ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: height,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 4,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          spacing: 10,
                          children: [
                            const Text("Search In"),
                            ...SearchInField.values.map(
                                  (field) =>
                                  FilterChip(
                                    label: Text(capitalize(field.name)),
                                    selected: curQuery.searchInFields.contains(
                                      field,
                                    ),
                                    onSelected: (value) async =>
                                        ref.updateQuery(
                                              (query) =>
                                          query
                                            ..toggleSearchIn(field),
                                        ),
                                  ),
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          spacing: 4,
                          children: [
                            DropdownMenu<SortType>(
                              initialSelection: curQuery.sortField,
                              label: const Text("Sort Field"),
                              onSelected: (sort) async {
                                if (sort == null) {
                                  return;
                                }
                                ref.updateQuery(
                                      (query) => query..sortBy(sort),
                                );
                              },
                              dropdownMenuEntries: SortType.values
                                  .map(
                                    (e) =>
                                    DropdownMenuEntry(
                                      value: e,
                                      label: capitalize(e.apiValue),
                                    ),
                              )
                                  .toList(),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                ref.updateQuery(
                                      (query) =>
                                  query
                                    ..sortOrder = query.sortOrder.toggle(),
                                );
                              },
                              child: Icon(
                                curQuery.sortOrder.isAsc
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          spacing: 4,
                          children: [
                            DropdownMenu<SearchType>(
                              label: const Text("Search Type"),
                              initialSelection: curQuery.searchType,
                              onSelected: (sort) async {
                                if (sort == null) {
                                  return;
                                }
                                ref.updateQuery(
                                      (query) => query..searchType = sort,
                                );
                              },
                              dropdownMenuEntries: SearchType.values
                                  .map(
                                    (e) =>
                                    DropdownMenuEntry(
                                      value: e,
                                      label: capitalize(e.apiValue),
                                    ),
                              )
                                  .toList(),
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    final newDate = await showDatePicker(
                                      context: context,
                                      initialDate:
                                      curQuery.startDate ?? DateTime.now(),
                                      firstDate: DateTime(1900),
                                      // disallow future dates
                                      lastDate: DateTime.now(),
                                    );
                                    logger.i(newDate);
                                    ref.updateQuery(
                                          (query) => query..startDate = newDate,
                                    );
                                  },
                                  child: Text(
                                    "From: ${formatDate(curQuery.startDate)}",
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    final newDate = await showDatePicker(
                                      context: context,
                                      initialDate:
                                      curQuery.startDate ?? DateTime.now(),
                                      firstDate:
                                      curQuery.startDate ?? DateTime(1900),
                                      // disallow future dates
                                      lastDate: DateTime.now(),
                                    );

                                    ref.updateQuery(
                                          (query) => query..endDate = newDate,
                                    );
                                  },
                                  child: Text(
                                    "Till: ${formatDate(curQuery.endDate)}",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}

String formatDate(DateTime? dat) {
  if (dat == null) {
    return "";
  }
  return DateFormat('d MMM yy').format(dat);
}

String capitalize(String name) => name[0].toUpperCase() + name.substring(1);

class MamNotSetup extends ConsumerWidget {
  const MamNotSetup({required this.status, super.key});

  final String status;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            status,
            style: const TextStyle(fontSize: 20),
          ),
          if (status == errMamNotSetupAdmin)
            ElevatedButton(
              onPressed: () {
                ref.read(pageIndexProvider.notifier).switchPage(2);
                ref.read(settingsTabIndexProvider.notifier).set(1);
              },
              child: const Text(
                "Setup Now",
              ),
            ),
        ],
      ),
    );
  }
}
