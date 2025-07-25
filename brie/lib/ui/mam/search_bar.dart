import 'package:brie/clients/mam_api.dart';
import 'package:brie/clients/mam_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MamSearchBar extends HookConsumerWidget {
  const MamSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final search = useSearchController();
    final selectedSort = useState<SortType>(SortType.defaultSort);

    // Define general options as separate chips
    final generalOptions = {
      SortType.defaultSort: 'Default',
      SortType.random: 'Random',
    };

    // Define sort categories with their options
    final sortCategories = {
      'Title': {
        SortType.titleAsc: 'A-Z',
        SortType.titleDesc: 'Z-A',
      },
      'Date': {
        SortType.dateDesc: 'Newest',
        SortType.dateAsc: 'Oldest',
      },
      'Popularity': {
        SortType.seedersDesc: 'Most Seeders',
        SortType.seedersAsc: 'Least Seeders',
        SortType.leechersDesc: 'Most Leechers',
        SortType.leechersAsc: 'Least Leechers',
        SortType.snatchedDesc: 'Most Snatched',
        SortType.snatchedAsc: 'Least Snatched',
      },
      'Size & Files': {
        SortType.sizeDesc: 'Largest',
        SortType.sizeAsc: 'Smallest',
        SortType.fileDesc: 'Most Files',
        SortType.fileAsc: 'Least Files',
      },
      'Category': {
        SortType.categoryAsc: 'A-Z',
        SortType.categoryDesc: 'Z-A',
      },
      'Bookmarks': {
        SortType.bmkaDesc: 'Recent',
        SortType.bmkaAsc: 'Oldest',
      },
      'Reseed': {
        SortType.reseedDesc: 'Recent Request',
        SortType.reseedAsc: 'Oldest Request',
      },
    };

    // Helper function to check if any option in this category is selected
    bool isCategorySelected(Map<SortType, String> options) {
      return options.containsKey(selectedSort.value);
    }

    // Helper function to get current value for this category
    SortType? getCategoryValue(Map<SortType, String> options) {
      return options.containsKey(selectedSort.value)
          ? selectedSort.value
          : null;
    }

    Widget buildDropdownFilterChip(
      String categoryTitle,
      Map<SortType, String> options,
    ) {
      final theme = Theme.of(context);
      final isSelected = isCategorySelected(options);
      final currentValue = getCategoryValue(options);

      // Convert SortType options to FilterChipItem list
      final items = options.entries.map((entry) {
        return FilterChipItem(
          label: entry.value,
          value: entry.key.toString(),
        );
      }).toList();

      // Determine the initial label
      String initialLabel;
      if (isSelected && currentValue != null) {
        initialLabel = '$categoryTitle: ${options[currentValue]}';
      } else {
        initialLabel = categoryTitle;
      }

      return FilterChipDropdown(
        items: items,
        initialLabel: initialLabel,
        unselectedColor:
            theme.chipTheme.backgroundColor ?? theme.colorScheme.surface,
        unselectedLabelColor:
            theme.chipTheme.labelStyle?.color ?? theme.colorScheme.onSurface,
        selectedColor:
            theme.chipTheme.selectedColor ?? theme.colorScheme.primaryContainer,
        selectedLabelColor:
            theme.chipTheme.secondarySelectedColor ??
            theme.colorScheme.onPrimaryContainer,
        onSelectionChanged: (value) {
          if (value != null) {
            // Find the SortType that matches the selected value
            final sortType = options.entries
                .firstWhere((entry) => entry.key.toString() == value)
                .key;
            selectedSort.value = sortType;
            ref.read(mamBooksSearchNotifier.notifier).searchWithSort(sortType);
          } else {
            // Handle deselection - revert to default sort
            selectedSort.value = SortType.defaultSort;
            ref
                .read(mamBooksSearchNotifier.notifier)
                .searchWithSort(SortType.defaultSort);
          }
        },
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search TextField
        TextField(
          controller: search,
          decoration: const InputDecoration(
            hintText: 'Search books...',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
          onSubmitted: (value) {
            ref.read(mamBooksSearchNotifier.notifier).searchNew(value);
          },
        ),

        const SizedBox(height: 16),

        // Filter Chips
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            // General options as normal FilterChips
            ...generalOptions.entries.map((entry) {
              final isSelected = selectedSort.value == entry.key;
              return FilterChip(
                label: Text(entry.value),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) {
                    selectedSort.value = entry.key;
                    ref
                        .read(mamBooksSearchNotifier.notifier)
                        .searchWithSort(entry.key);
                  }
                },
              );
            }),

            // Dropdown filter chips for other categories
            ...sortCategories.entries.map((categoryEntry) {
              return buildDropdownFilterChip(
                categoryEntry.key,
                categoryEntry.value,
              );
            }),
          ],
        ),
      ],
    );
  }
}

// thanks: https://github.com/flutter/flutter/issues/108683#issuecomment-1200304171
class FilterChipItem {
  const FilterChipItem({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;
}

class FilterChipDropdown extends StatefulWidget {
  const FilterChipDropdown({
    required this.items,
    required this.initialLabel,
    required this.unselectedColor,
    required this.unselectedLabelColor,
    required this.selectedColor,
    required this.selectedLabelColor,
    required this.onSelectionChanged,
    this.leading,
    this.labelPadding = 16,
    super.key,
  });

  final List<FilterChipItem> items;
  final Widget? leading;
  final String initialLabel;
  final Color unselectedColor;
  final Color unselectedLabelColor;
  final Color selectedColor;
  final Color selectedLabelColor;
  final Function(String?) onSelectionChanged;
  final double labelPadding;

  @override
  _FilterChipDropdownState createState() => _FilterChipDropdownState();
}

class _FilterChipDropdownState extends State<FilterChipDropdown> {
  final GlobalKey _chipKey = GlobalKey();

  late String _selectedLabel;
  bool _isSelected = false;
  bool _isDropdownOpen = false;
  double _maxItemWidth = 0;

  @override
  void initState() {
    super.initState();
    _selectedLabel = widget.initialLabel;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateMaxItemWidth();
    });
  }

  void _toggleDropdown(bool? value) {
    setState(() {
      _isDropdownOpen = !_isDropdownOpen;
    });
  }

  void _selectItem(FilterChipItem item) {
    setState(() {
      _selectedLabel = item.label;
      _isSelected = true;
      _isDropdownOpen = false;
    });
    widget.onSelectionChanged(item.value);
  }

  void _clearSelection() {
    setState(() {
      _selectedLabel = widget.initialLabel;
      _isSelected = false;
      _isDropdownOpen = false;
    });
    widget.onSelectionChanged(null);
  }

  void _handleOutsideTap(PointerDownEvent evt) {
    if (_isDropdownOpen) {
      setState(() {
        _isDropdownOpen = false;
      });
    }
  }

  void _calculateMaxItemWidth() {
    double maxWidth = 0;
    for (var item in widget.items) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: item.label,
          style: DefaultTextStyle.of(context).style,
        ),
        maxLines: 1,
        textDirection: TextDirection.ltr,
      )..layout();
      maxWidth = maxWidth < textPainter.width
          ? textPainter.width + 2 * widget.labelPadding
          : maxWidth;
    }

    final chipBox = _chipKey.currentContext?.findRenderObject() as RenderBox?;
    double chipWidth = chipBox?.size.width ?? 0;
    setState(() {
      _maxItemWidth = maxWidth > chipWidth ? maxWidth : chipWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      onTapOutside: _handleOutsideTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilterChip.elevated(
            key: _chipKey,
            avatar: widget.leading,
            label: Text(
              _selectedLabel,
            ),
            iconTheme: IconThemeData(
              color: _isSelected
                  ? widget.selectedLabelColor
                  : widget.unselectedLabelColor,
            ),
            labelStyle: TextStyle(
              color: _isSelected
                  ? widget.selectedLabelColor
                  : widget.unselectedLabelColor,
            ),
            backgroundColor: _isSelected
                ? widget.selectedColor
                : widget.unselectedColor,
            deleteIcon: _isSelected
                ? Icon(Icons.close, color: widget.selectedLabelColor)
                : Icon(
                    Icons.arrow_drop_down,
                    color: widget.unselectedLabelColor,
                  ),
            onDeleted: _isSelected
                ? _clearSelection
                : () => _toggleDropdown(false),
            onSelected: _toggleDropdown,
          ),
          if (_isDropdownOpen)
            Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(4),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: _maxItemWidth,
                      maxWidth: MediaQuery.of(context).size.width * 0.9,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.items.map((item) {
                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => _selectItem(item),
                            child: Container(
                              width: _maxItemWidth,
                              padding: EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: widget.labelPadding,
                              ),
                              child: Text(item.label),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
