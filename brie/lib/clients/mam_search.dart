enum SearchType {
  all,
  active,
  inactive,
  fl,
  flVip('fl-VIP'),
  vip('VIP'),
  nvip('nVIP'),
  nmeta('nMeta');

  const SearchType([this.value]);

  final String? value;

  String get apiValue => value ?? name;
}

enum SortType {
  titleAsc,
  titleDesc,
  fileAsc,
  fileDesc,
  sizeAsc,
  sizeDesc,
  seedersAsc,
  seedersDesc,
  leechersAsc,
  leechersDesc,
  snatchedAsc,
  snatchedDesc,
  dateAsc,
  dateDesc,
  bmkaAsc,
  bmkaDesc,
  reseedAsc,
  reseedDesc,
  categoryAsc,
  categoryDesc,
  random,
  defaultSort('default');

  const SortType([this.value]);

  final String? value;

  String get apiValue => value ?? name;
}

enum MainCategory {
  audioBooks(13),
  eBooks(14),
  musicology(15),
  radio(16);

  const MainCategory(this.id);

  final int id;
}

enum SearchInField {
  title,
  author,
  description,
  filenames,
  fileTypes,
  narrator,
  series,
  tags,
}

// Main search query builder class
class MamSearchQuery {
  MamSearchQuery();

  // Core search parameters
  String? text;
  List<SearchInField> searchInFields = [];
  SearchType searchType = SearchType.all;
  String searchIn = 'torrents';

  // Categories and languages
  List<String> categories = [];
  List<int> browseLanguages = [];
  List<MainCategory> mainCategories = [];

  // Date filters
  DateTime? startDate;
  DateTime? endDate;

  // Hash and ISBN
  String? hash;
  bool includeIsbn = false;

  // Sorting and pagination
  SortType sortType = SortType.defaultSort;
  int startNumber = 0;
  int perPage = 25;

  // Additional flags
  bool showDescription = false;
  bool showDlLink = false;
  bool showBookmarks = false;
  bool showThumbnail = false;
  String browseFlagsHideVsShow = '0';

  // Fluent builder methods
  MamSearchQuery withText(String searchText) {
    text = searchText;
    return this;
  }

  MamSearchQuery addSearchIn(List<SearchInField> fields) {
    searchInFields = List.from(fields);
    return this;
  }

  MamSearchQuery ofType(SearchType type) {
    searchType = type;
    return this;
  }

  MamSearchQuery inCategories(List<String> cats) {
    categories = List.from(cats);
    return this;
  }

  MamSearchQuery inMainCategories(List<MainCategory> cats) {
    mainCategories = List.from(cats);
    return this;
  }

  MamSearchQuery withLanguages(List<int> langs) {
    browseLanguages = List.from(langs);
    return this;
  }

  MamSearchQuery fromDate(DateTime date) {
    startDate = date;
    return this;
  }

  MamSearchQuery toDate(DateTime date) {
    endDate = date;
    return this;
  }

  MamSearchQuery withHash(String torrentHash) {
    hash = torrentHash;
    return this;
  }

  MamSearchQuery sortBy(SortType sort) {
    sortType = sort;
    return this;
  }

  MamSearchQuery startAt(int start) {
    startNumber = start;
    return this;
  }

  MamSearchQuery resultsPerPage(int count) {
    if (count < 5 || count > 100) {
      throw ArgumentError('perPage must be between 5 and 100');
    }
    perPage = count;
    return this;
  }

  MamSearchQuery includeDescription() {
    showDescription = true;
    return this;
  }

  MamSearchQuery includeDlLink() {
    showDlLink = true;
    return this;
  }

  MamSearchQuery includeBookmarks() {
    showBookmarks = true;
    return this;
  }

  MamSearchQuery includeThumbnail() {
    showThumbnail = true;
    return this;
  }

  MamSearchQuery withIsbn() {
    includeIsbn = true;
    return this;
  }

  // Convert to JSON for API request
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> torData = {
      'cat': categories.isEmpty ? ['0'] : categories,
      'sortType': sortType.apiValue,
      'browseStart': true,
      'startNumber': startNumber.toString(),
      'searchType': searchType.apiValue,
      'searchIn': searchIn,
      'browseFlagsHideVsShow': browseFlagsHideVsShow,
    };

    // Add text search
    if (text != null && text!.isNotEmpty) {
      torData['text'] = text;
    }

    // Add search fields
    if (searchInFields.isNotEmpty) {
      torData['srchIn'] = searchInFields.map((f) => f.name).toList();
    }

    // Add date filters
    if (startDate != null) {
      torData['startDate'] = _formatDate(startDate!);
    }
    if (endDate != null) {
      torData['endDate'] = _formatDate(endDate!);
    }

    // Add hash
    if (hash != null && hash!.isNotEmpty) {
      torData['hash'] = hash;
    }

    // Add main categories
    if (mainCategories.isNotEmpty) {
      torData['main_cat'] = mainCategories.map((c) => c.id).toList();
    }

    // Add browse languages
    if (browseLanguages.isNotEmpty) {
      torData['browse_lang'] = browseLanguages;
    }

    // Add per page
    torData['perpage'] = perPage;

    final Map<String, dynamic> result = {'tor': torData};

    // Add flags
    if (showDescription) result['description'] = '';
    if (showDlLink) result['dlLink'] = '';
    if (showBookmarks) result['bookmarks'] = '';
    if (showThumbnail) result['thumbnail'] = 'true';
    if (includeIsbn) result['isbn'] = '';

    return result;
  }

  String _formatDate(DateTime date) {
    return '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  // Clone method for immutable-style operations
  MamSearchQuery clone() {
    return MamSearchQuery()
      ..text = text
      ..searchInFields = List.from(searchInFields)
      ..searchType = searchType
      ..searchIn = searchIn
      ..categories = List.from(categories)
      ..browseLanguages = List.from(browseLanguages)
      ..mainCategories = List.from(mainCategories)
      ..startDate = startDate
      ..endDate = endDate
      ..hash = hash
      ..includeIsbn = includeIsbn
      ..sortType = sortType
      ..startNumber = startNumber
      ..perPage = perPage
      ..showDescription = showDescription
      ..showDlLink = showDlLink
      ..showBookmarks = showBookmarks
      ..showThumbnail = showThumbnail
      ..browseFlagsHideVsShow = browseFlagsHideVsShow;
  }
}

// Usage examples:
// void main() {
//   // Example 1: Simple text search
//   final query1 = MamSearchQuery()
//       .withText('collection cookbooks food test kitchen')
//       .searchIn([
//         SearchInField.title,
//         SearchInField.author,
//         SearchInField.narrator,
//       ])
//       .includeThumbnail();
//
//   print('Query 1 JSON:');
//   print(query1.toJson());
//
//   // Example 2: Complex search with filters
//   final query2 = MamSearchQuery()
//       .withText('mp3 m4a')
//       .ofType(SearchType.active)
//       .inMainCategories([MainCategory.audioBooks])
//       .sortBy(SortType.seedersDesc)
//       .resultsPerPage(50)
//       .fromDate(DateTime(2023, 1, 1))
//       .includeDescription()
//       .includeDlLink();
//
//   print('\nQuery 2 Form Data:');
//   print(query2.toFormData());
//
//   // Example 3: Chaining and cloning
//   final baseQuery = MamSearchQuery()
//       .ofType(SearchType.fl)
//       .sortBy(SortType.dateDesc);
//
//   final ebookQuery = baseQuery
//       .clone()
//       .inMainCategories([MainCategory.eBooks])
//       .withText('programming');
//
//   final audiobookQuery = baseQuery
//       .clone()
//       .inMainCategories([MainCategory.audioBooks])
//       .withText('sci-fi');
//
//   print('\nEbook Query JSON:');
//   print(ebookQuery.toJson());
//
//   print('\nAudiobook Query JSON:');
//   print(audiobookQuery.toJson());
// }
