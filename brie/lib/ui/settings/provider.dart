import 'package:brie/clients/settings_api.dart';
import 'package:brie/clients/user_api.dart';
import 'package:brie/gen/settings/v1/settings.pb.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabIndexNotifier extends Notifier<int> {
  @override
  int build() => kDebugMode ? 3 : 0;

  void set(int newIndex) => state = newIndex;
}

final settingsTabIndexProvider = NotifierProvider<TabIndexNotifier, int>(
  TabIndexNotifier.new,
);

final isAdminProvider = FutureProvider<bool>((ref) async {
  final userData = await ref.watch(userInfoProvider.future);
  return userData.role == "admin";
});

extension ConfigUpdateExtension on WidgetRef {
  void serverUpdateConfig(GoudaConfig Function(GoudaConfig) update) {
    read(serverConfigProvider.notifier).updateConfigField(update);
  }
}

final AsyncNotifierProvider<ServerConfigNotifier, GoudaConfig>
serverConfigProvider =
    AsyncNotifierProvider.autoDispose<ServerConfigNotifier, GoudaConfig>(
      ServerConfigNotifier.new,
    );

class ServerConfigNotifier extends AsyncNotifier<GoudaConfig> {
  @override
  Future<GoudaConfig> build() async => fetchConfig();

  Future<GoudaConfig> fetchConfig() async {
    final response = await mustRunGrpcRequest(
      () => ref.watch(settingsApiProvider).loadSettings(LoadSettingsRequest()),
    );
    return response.settings;
  }

  Future<void> saveAndFetch(
    Future<void> Function() updateFn,
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await updateFn();
      return fetchConfig();
    });
  }

  Future<void> updateConfig() async {
    await saveAndFetch(
      () async => ref
          .watch(settingsApiProvider)
          .updateSettings(UpdateSettingsRequest(settings: state.value)),
    );
  }

  Future<void> updateMam() async {
    await saveAndFetch(
      () async => ref
          .watch(settingsApiProvider)
          .updateMam(
            UpdateMamRequest(
              mamToken: state.requireValue.mamToken,
            ),
          ),
    );
  }

  Future<void> updateDownloader() async {
    await saveAndFetch(
      () async => ref
          .watch(settingsApiProvider)
          .updateDownloader(
            UpdateDownloaderRequest(
              client: state.requireValue.torrentClient,
              downloader: state.requireValue.downloader,
            ),
          ),
    );
  }

  Future<void> updateDirs() async {
    await saveAndFetch(
      () async => ref
          .watch(settingsApiProvider)
          .updateDir(
            UpdateDirRequest(
              dirs: state.requireValue.dir,
              perms: state.requireValue.permissions,
            ),
          ),
    );
  }

  void updateConfigField(
    GoudaConfig Function(GoudaConfig existingConfig) updateConfig,
  ) {
    final curConfig = state.value!.deepCopy();
    final newConfig = updateConfig(curConfig);

    // logger.d("Updating config: $config");
    state = AsyncValue.data(newConfig);
  }
}
