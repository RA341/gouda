class TorrentClient {
  final String user;
  final String password;
  final String protocol;
  final String host;
  final String type;

  TorrentClient({
    required this.user,
    required this.password,
    required this.protocol,
    required this.host,
    required this.type,
  });

  factory TorrentClient.fromJson(Map<String, dynamic> json) {
    return TorrentClient(
      user: json['user'] ?? '',
      password: json['password'] ?? '',
      protocol: json['protocol'] ?? '',
      host: json['host'] ?? '',
      type: json['type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'user': user,
        'password': password,
        'protocol': protocol,
        'host': host,
        'type': type,
      };
}

class TorrentRequest {
  final String fileLink;
  final String author;
  final String book;
  final String category;
  final String mamUrl;

  TorrentRequest({
    required this.fileLink,
    required this.author,
    required this.book,
    required this.category,
    required this.mamUrl,
  });

  Map<String, dynamic> toJson() => {
        'file_link': fileLink,
        'author': author,
        'book': book,
        'category': category,
        'mam_url': mamUrl,
      };
}

class TorrentStatus {
  final String name;
  final String percentProgress;
  final String downloadPath;
  final String status;

  TorrentStatus({
    required this.name,
    required this.percentProgress,
    required this.downloadPath,
    required this.status,
  });

  factory TorrentStatus.fromJson(Map<String, dynamic> json) {
    return TorrentStatus(
      name: json['name'] ?? '',
      percentProgress: json['percent_complete'] ?? '',
      downloadPath: json['download_path'] ?? '',
      status: json['status'] ?? '',
    );
  }
}

class Settings {
  // General
  final String apiKey;
  final String serverPort;
  final int downloadCheckTimeout;

  // Folders
  final String completeFolder;
  final String downloadFolder;
  final String torrentsFolder;

  // User details
  final String username;
  final String password;
  final int userID;
  final int groupID;

  // Torrent settings
  final String torrentHost;
  final String torrentName;
  final String torrentPassword;
  final String torrentProtocol;
  final String torrentUser;

  Settings({
    required this.apiKey,
    required this.serverPort,
    required this.downloadCheckTimeout,
    required this.completeFolder,
    required this.downloadFolder,
    required this.torrentsFolder,
    required this.username,
    required this.password,
    required this.userID,
    required this.groupID,
    required this.torrentHost,
    required this.torrentName,
    required this.torrentPassword,
    required this.torrentProtocol,
    required this.torrentUser,
  });

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      apiKey: json['api_key'] as String,
      serverPort: json['server_port'] as String,
      downloadCheckTimeout: json['download_check_timeout'] as int,
      completeFolder: json['complete_folder'] as String,
      downloadFolder: json['download_folder'] as String,
      torrentsFolder: json['torrents_folder'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      userID: json['user_uid'] as int,
      groupID: json['group_uid'] as int,
      torrentHost: json['torrent_host'] as String,
      torrentName: json['torrent_name'] as String,
      torrentPassword: json['torrent_password'] as String,
      torrentProtocol: json['torrent_protocol'] as String,
      torrentUser: json['torrent_user'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'api_key': apiKey,
      'server_port': serverPort,
      'download_check_timeout': downloadCheckTimeout,
      'complete_folder': completeFolder,
      'download_folder': downloadFolder,
      'torrents_folder': torrentsFolder,
      'username': username,
      'password': password,
      'user_uid': userID,
      'group_uid': groupID,
      'torrent_host': torrentHost,
      'torrent_name': torrentName,
      'torrent_password': torrentPassword,
      'torrent_protocol': torrentProtocol,
      'torrent_user': torrentUser,
    };
  }
}

class Book {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String fileLink;
  final String author;
  final String book;
  final String category;
  final int mamBookId;
  final String status;
  final String torrentId;

  Book({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.fileLink,
    required this.author,
    required this.book,
    required this.category,
    required this.mamBookId,
    required this.status,
    required this.torrentId,
  });

  // From JSON
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['ID'] as int,
      createdAt: DateTime.parse(json['CreatedAt'] as String),
      updatedAt: DateTime.parse(json['UpdatedAt'] as String),
      deletedAt: json['DeletedAt'] != null
          ? DateTime.parse(json['DeletedAt'] as String)
          : null,
      fileLink: json['file_link'] as String,
      author: json['author'] as String,
      book: json['book'] as String,
      category: json['category'] as String,
      mamBookId: json['mam_book_id'] as int,
      status: json['status'] as String,
      torrentId: json['torrent_id'] as String,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'CreatedAt': createdAt.toIso8601String(),
      'UpdatedAt': updatedAt.toIso8601String(),
      'DeletedAt': deletedAt?.toIso8601String(),
      'file_link': fileLink,
      'author': author,
      'book': book,
      'category': category,
      'mam_book_id': mamBookId,
      'status': status,
      'torrent_id': torrentId,
    };
  }

  // Copy with method for immutability
  Book copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    String? fileLink,
    String? author,
    String? book,
    String? category,
    int? mamBookId,
    String? status,
    String? torrentId,
  }) {
    return Book(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      fileLink: fileLink ?? this.fileLink,
      author: author ?? this.author,
      book: book ?? this.book,
      category: category ?? this.category,
      mamBookId: mamBookId ?? this.mamBookId,
      status: status ?? this.status,
      torrentId: torrentId ?? this.torrentId,
    );
  }
}