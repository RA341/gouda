import 'dart:convert';

import 'package:brie/api/api.dart';
import 'package:brie/models.dart';

final torrentClient = TorrentApi();

class TorrentApi {
  // Add Torrent Client
  static Future<void> addTorrentClient(TorrentClient client) async {
    try {
      final response = await apiClient.post(
        '/torrents/addTorrentClient',
        data: jsonEncode(client.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to add torrent client: ${response.data}');
      }
    } catch (e) {
      throw Exception('Error adding torrent client: $e');
    }
  }

  // Get Torrent Client
  static Future<TorrentClient> getTorrentClient() async {
    try {
      final response = await apiClient.get('/torrents/torrentclient');

      if (response.statusCode == 200) {
        return TorrentClient.fromJson(jsonDecode(response.data));
      } else {
        throw Exception('Failed to get torrent client: ${response.data}');
      }
    } catch (e) {
      throw Exception('Error getting torrent client: $e');
    }
  }

  // Add Torrent
  static Future<void> addTorrent(TorrentRequest request) async {
    try {
      final response = await apiClient.post(
        '/torrents/addTorrent',
        data: jsonEncode(request.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to add torrent: ${response.data}');
      }
    } catch (e) {
      throw Exception('Error adding torrent: $e');
    }
  }
}
