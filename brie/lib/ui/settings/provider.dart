import 'package:brie/clients/settings_api.dart';
import 'package:brie/clients/user_api.dart';
import 'package:brie/gen/settings/v1/settings.pb.dart';
import 'package:brie/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabIndexNotifier extends Notifier<int> {
  @override
  int build() => kDebugMode ? 2 : 0;

  void set(int newIndex) => state = newIndex;
}

final settingsTabIndexProvider = NotifierProvider<TabIndexNotifier, int>(
  TabIndexNotifier.new,
);

final isAdminProvider = FutureProvider<bool>((ref) async {
  final userData = await ref.watch(userInfoProvider.future);
  return userData.role == "admin";
});

class ServerConfigNotifier extends AsyncNotifier<GoudaConfig> {
  @override
  Future<GoudaConfig> build() async => fetchConfig();

  Future<GoudaConfig> fetchConfig() async {
    final response = await ref
        .watch(settingsApiProvider)
        .loadSettings(LoadSettingsRequest());
    return response.settings;
  }

  Future<void> saveConfig() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref
          .watch(settingsApiProvider)
          .updateSettings(UpdateSettingsRequest(settings: state.value));

      return fetchConfig();
    });
  }

  Future<void> updateFolderConfig(UserPermissions perms,
      Directories dirs,) async {
    // todo
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref
          .watch(settingsApiProvider)
          .updateSettings(UpdateSettingsRequest(settings: state.value));

      return fetchConfig();
    });
  }

  void updateLocalConfig(GoudaConfig config) {
    logger.d("Updating config: $config");
    state = AsyncValue.data(config);
  }

  void updateConfigField(
    GoudaConfig Function(GoudaConfig existingConfig) updateConfig,
  ) {
    final curConfig = state.value!;
    final newConfig = updateConfig(curConfig);
    updateLocalConfig(newConfig);
  }
}

final AsyncNotifierProvider<ServerConfigNotifier, GoudaConfig>
serverConfigProvider =
    AsyncNotifierProvider.autoDispose<ServerConfigNotifier, GoudaConfig>(
      ServerConfigNotifier.new,
    );
