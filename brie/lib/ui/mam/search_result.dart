import 'package:brie/clients/history_api.dart';
import 'package:brie/gen/mam/v1/mam.pb.dart';
import 'package:brie/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class BookItem extends StatelessWidget {
  const BookItem({required this.book, super.key});

  final SearchBook book;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ExpansionTile(
        leading: ThumbnailWidget(book: book),
        title: Text(
          book.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthorsList(authors: book.author),
            const SizedBox(height: 4),
            Row(
              children: [
                CategoryChip(book: book),
                const SizedBox(width: 8),
                FormatChip(format: book.mediaFormat),
              ],
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InfoRow(label: 'Size', value: book.mediaSize),
                // todo
                // InfoRow(label: 'Length', value: "Unknown"),
                InfoRow(label: 'Added', value: _formatDate(book.dateAddedIso)),
                SeedersInfo(book: book),
                if (book.tags.isNotEmpty) TagsWidget(tags: book.tags),
                const SizedBox(height: 12),
                DescriptionView(book: book),
                const SizedBox(height: 12),
                ActionButtons(book: book),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    if (dateString.isEmpty) return '';

    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays == 0) {
        return 'Today';
      } else if (difference.inDays == 1) {
        return 'Yesterday';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} days ago';
      } else {
        return '${date.day}/${date.month}/${date.year}';
      }
    } catch (e) {
      return dateString; // Return original string if parsing fails
    }
  }
}

class AuthorsList extends StatelessWidget {
  const AuthorsList({
    required this.authors,
    this.maxAuthors = 2,
    super.key,
  });

  final List<Author> authors;
  final int maxAuthors;

  @override
  Widget build(BuildContext context) {
    // ...book.author.map(
    // (element) =>
    // Text(element.name, style: TextStyle(color: Colors.grey[600])),
    // )
    final authorOverflow = authors.length > maxAuthors;

    return Row(
      spacing: 10,
      children: [
        ...authors
            .take(maxAuthors)
            .map(
              (e) => StringLink(
                data: e.name,
                onPress: (data) {
                  // todo
                },
              ),
            ),
        if (authorOverflow) Text('and ${authors.length - maxAuthors} more'),
      ],
    );
  }
}

class DescriptionView extends StatelessWidget {
  const DescriptionView({required this.book, super.key});

  final SearchBook book;

  @override
  Widget build(BuildContext context) {
    return Text(
      book.description,
      style: const TextStyle(overflow: TextOverflow.ellipsis),
    );
  }
}

class StringLink extends ConsumerWidget {
  const StringLink({
    required this.data,
    required this.onPress,
    super.key,
  });

  final String data;
  final void Function(String data) onPress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      child: Text(
        data,
        style: TextStyle(color: Colors.blue[200]),
      ),
      onTap: () => onPress(data),
    );
  }
}

class ThumbnailWidget extends StatelessWidget {
  const ThumbnailWidget({required this.book, super.key});

  final SearchBook book;

  @override
  Widget build(BuildContext context) {
    if (book.thumbnail.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Image.network(
          book.thumbnail,
          width: 50,
          height: 70,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              _loadMediaCategoryIcon(book.mediaCategory),
        ),
      );
    }
    return _loadMediaCategoryIcon(book.mediaCategory);
  }
}

Icon _loadMediaCategoryIcon(String category) {
  switch (category) {
    case 'AudioBooks':
      return const Icon(Icons.headphones, color: Colors.pinkAccent, size: 32);
    case 'Musicology':
      return const Icon(Icons.music_note, color: Colors.blueAccent, size: 32);
    case 'Radio':
      return const Icon(Icons.radio, color: Colors.redAccent, size: 32);
    case 'EBooks':
    default:
      return const Icon(Icons.book_rounded, color: Colors.teal, size: 32);
  }
}

Color _getCategoryColor(SearchBook book) {
  switch (book.mediaCategory) {
    case 'AudioBooks':
      return Colors.pinkAccent;
    case 'Musicology':
      return Colors.blueAccent;
    case 'Radio':
      return Colors.redAccent;
    case 'EBooks':
    default:
      return Colors.teal;
  }
}

class CategoryChip extends StatelessWidget {
  const CategoryChip({required this.book, super.key});

  final SearchBook book;

  @override
  Widget build(BuildContext context) {
    final color = _getCategoryColor(book);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(50),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        book.tags,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }
}

class FormatChip extends StatelessWidget {
  const FormatChip({required this.format, super.key});

  final String format;

  @override
  Widget build(BuildContext context) {
    if (format.isEmpty) return const SizedBox.shrink();

    final lower = format.toLowerCase();
    final backgroundColor = switch (lower) {
      'mp3' => Colors.indigo[700],
      'm4a' => Colors.teal[700],
      'm4b' => Colors.green[800],
      'flac' => Colors.cyan[900],
      'epub' => Colors.deepPurple[600],
      'mobi' => Colors.brown[600],
      'azw3' => Colors.orange[800],
      'pdf' => Colors.red[900],
      _ => Colors.blueGrey[700],
    };

    final textColor = switch (lower) {
      'azw3' => Colors.black87,
      _ => Colors.grey[100],
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        format.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  const InfoRow({required this.label, required this.value, super.key});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    if (value.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 60,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class SeedersInfo extends StatelessWidget {
  const SeedersInfo({required this.book, super.key});

  final SearchBook book;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(
            Icons.cloud_upload_outlined,
            size: 16,
            color: book.seeders > 0 ? Colors.green : Colors.red,
          ),
          const SizedBox(width: 4),
          Text(
            '${book.seeders} seeders',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: book.seeders > 0 ? Colors.green : Colors.red,
            ),
          ),
          const SizedBox(width: 16),
          const Icon(
            Icons.cloud_download_outlined,
            size: 16,
            color: Colors.orange,
          ),
          const SizedBox(width: 4),
          Text(
            '${book.leechers} leechers',
            style: const TextStyle(color: Colors.orange),
          ),
          const SizedBox(width: 16),
          const Icon(Icons.check_circle_outline, size: 16, color: Colors.blue),
          const SizedBox(width: 4),
          Text(
            '${book.completed} completed',
            style: const TextStyle(color: Colors.blue),
          ),
        ],
      ),
    );
  }
}

class TagsWidget extends StatelessWidget {
  const TagsWidget({required this.tags, super.key});

  final String tags;

  @override
  Widget build(BuildContext context) {
    final tagList = tags
        .split(',')
        .map((tag) => tag.trim())
        .where((tag) => tag.isNotEmpty)
        .toList();

    if (tagList.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          'Tags:',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        Wrap(
          spacing: 4,
          runSpacing: 4,
          children: tagList
              .map(
                (tag) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[260],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue[200]!),
                  ),
                  child: Text(
                    tag,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[400],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class ActionButtons extends HookConsumerWidget {
  const ActionButtons({
    required this.book,
    super.key,
  });

  final SearchBook book;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasTorrentLink = book.torrentLink.isNotEmpty;
    final history = ref.watch(historyApiProvider);
    final cats = ref.watch(categoryListProvider).value ?? [];
    final selectedCat = useState('');

    final allowDownload = selectedCat.value.isNotEmpty && hasTorrentLink;
    // final isFreeleechAble = book.

    return Row(
      spacing: 30,
      children: [
        // Category Dropdown
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            value: selectedCat.value.isEmpty ? null : selectedCat.value,
            hint: const Text('Select Category'),
            underline: const SizedBox(),
            items: cats.map<DropdownMenuItem<String>>((category) {
              return DropdownMenuItem<String>(
                value: category.category,
                child: Text(category.category),
              );
            }).toList(),
            onChanged: (String? newValue) {
              selectedCat.value = newValue ?? '';
            },
          ),
        ),

        ElevatedButton.icon(
          onPressed: allowDownload
              ? () {
                  if (!context.mounted) return;
                  history.download(book, selectedCat.value);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Downloading ${book.title}...'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              : null,
          icon: const Icon(Icons.download, size: 18),
          label: const Text('Download'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal[700],
            foregroundColor: Colors.grey[200],
          ),
        ),
        ElevatedButton.icon(
          onPressed: allowDownload
              ? () {
                  if (!context.mounted) return;
                  history.download(book, selectedCat.value, useFreeleech: true);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Downloading ${book.title} with freeleech...',
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              : null,
          icon: const Icon(LineAwesomeIcons.cheese_solid, size: 18),
          label: const Text('Download with wedge'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber[800],
            foregroundColor: Colors.black87,
          ),
        ),
      ],
    );
  }
}

class ChipDropdown extends ConsumerWidget {
  const ChipDropdown({
    required this.items,
    required this.selectedItem,
    this.hint = 'Select items',
    super.key,
  });

  final ValueNotifier<String> selectedItem;
  final List<String> items;
  final String hint;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: selectedItem.value.isEmpty ? null : selectedItem.value,
        hint: Text(hint),
        underline: const SizedBox(),
        items: items.map<DropdownMenuItem<String>>((category) {
          return DropdownMenuItem<String>(
            value: category,
            child: Text(category),
          );
        }).toList(),
        onChanged: (String? newValue) {
          selectedItem.value = newValue ?? '';
        },
      ),
    );
  }
}
