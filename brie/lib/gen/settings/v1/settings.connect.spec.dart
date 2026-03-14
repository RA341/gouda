//
//  Generated code. Do not modify.
//  source: settings/v1/settings.proto
//

import "package:connectrpc/connect.dart" as connect;
import "settings.pb.dart" as settingsv1settings;

abstract final class SettingsService {
  /// Fully-qualified name of the SettingsService service.
  static const name = 'settings.v1.SettingsService';

  static const loadSettings = connect.Spec(
    '/$name/LoadSettings',
    connect.StreamType.unary,
    settingsv1settings.LoadSettingsRequest.new,
    settingsv1settings.LoadSettingsResponse.new,
  );

  static const updateSettings = connect.Spec(
    '/$name/UpdateSettings',
    connect.StreamType.unary,
    settingsv1settings.UpdateSettingsRequest.new,
    settingsv1settings.UpdateSettingsResponse.new,
  );

  static const updateMam = connect.Spec(
    '/$name/UpdateMam',
    connect.StreamType.unary,
    settingsv1settings.UpdateMamRequest.new,
    settingsv1settings.UpdateMamResponse.new,
  );

  static const updateDownloader = connect.Spec(
    '/$name/UpdateDownloader',
    connect.StreamType.unary,
    settingsv1settings.UpdateDownloaderRequest.new,
    settingsv1settings.UpdateDownloaderResponse.new,
  );

  static const updateDir = connect.Spec(
    '/$name/UpdateDir',
    connect.StreamType.unary,
    settingsv1settings.UpdateDirRequest.new,
    settingsv1settings.UpdateDirResponse.new,
  );

  static const listDirectories = connect.Spec(
    '/$name/ListDirectories',
    connect.StreamType.unary,
    settingsv1settings.ListDirectoriesRequest.new,
    settingsv1settings.ListDirectoriesResponse.new,
  );

  static const listSupportedClients = connect.Spec(
    '/$name/ListSupportedClients',
    connect.StreamType.unary,
    settingsv1settings.ListSupportedClientsRequest.new,
    settingsv1settings.ListSupportedClientsResponse.new,
  );

  static const testClient = connect.Spec(
    '/$name/TestClient',
    connect.StreamType.unary,
    settingsv1settings.TorrentClient.new,
    settingsv1settings.TestTorrentResponse.new,
  );

  static const getMetadata = connect.Spec(
    '/$name/GetMetadata',
    connect.StreamType.unary,
    settingsv1settings.GetMetadataRequest.new,
    settingsv1settings.GetMetadataResponse.new,
  );
}
