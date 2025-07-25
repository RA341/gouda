import 'package:brie/gen/mam/v1/mam.pb.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class BookItem extends StatelessWidget {
  const BookItem({required this.book, super.key});

  final Book book;

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
            Text(book.author, style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 4),
            Row(
              children: [
                CategoryChip(book: book),
                const SizedBox(width: 8),
                FormatChip(format: book.format),
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
                InfoRow(label: 'Size', value: book.size),
                InfoRow(label: 'Length', value: book.length),
                InfoRow(label: 'Added', value: _formatDate(book.added)),
                SeedersInfo(book: book),
                if (book.tags.isNotEmpty) TagsWidget(tags: book.tags),
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

class ThumbnailWidget extends StatelessWidget {
  const ThumbnailWidget({required this.book, super.key});

  final Book book;

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
              _loadIcon(book.category),
        ),
      );
    }
    return _loadIcon(book.category);
  }

  Icon _loadIcon(int category) {
    switch (category) {
      case 13: // audiobooks
        return const Icon(Icons.headphones, color: Colors.pinkAccent, size: 32);
      case 15: // musicology
        return const Icon(Icons.music_note, color: Colors.blueAccent, size: 32);
      case 16: // radio
        return const Icon(Icons.radio, color: Colors.redAccent, size: 32);
      default: // 14 -> ebooks and anything else
        return const Icon(Icons.book_rounded, color: Colors.teal, size: 32);
    }
  }
}

class CategoryChip extends StatelessWidget {
  const CategoryChip({required this.book, super.key});

  final Book book;

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
        _getCategoryName(book.category),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }

  String _getCategoryName(int category) {
    switch (category) {
      case 13:
        return 'Audiobook';
      case 15:
        return 'Music';
      case 16:
        return 'Radio';
      default:
        return 'eBook';
    }
  }
}

Color _getCategoryColor(Book book) {
  switch (book.category) {
    case 13:
      return Colors.pinkAccent;
    case 15:
      return Colors.blueAccent;
    case 16:
      return Colors.redAccent;
    default:
      return Colors.teal;
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

  final Book book;

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

class ActionButtons extends StatelessWidget {
  const ActionButtons({required this.book, super.key});

  final Book book;

  @override
  Widget build(BuildContext context) {
    final hasTorrentLink = book.torrentLink.isNotEmpty;

    return Row(
      spacing: 30,
      children: [
        ElevatedButton.icon(
          onPressed: hasTorrentLink
              ? () {
                  if (!context.mounted) return;
                  _downloadTorrent(context);
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
          onPressed: hasTorrentLink
              ? () {
                  if (!context.mounted) return;
                  _downloadTorrent(context);
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

  void _downloadTorrent(BuildContext context) {
    // Implement torrent download logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Downloading ${book.title}...'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _downloadTorrentWithFreeleech(BuildContext context) {
    // Implement torrent download logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Downloading ${book.title}...'),
        backgroundColor: Colors.green,
      ),
    );
  }
}
