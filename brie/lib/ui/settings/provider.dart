import 'package:brie/clients/settings_api.dart';
import 'package:brie/clients/user_api.dart';
import 'package:brie/gen/settings/v1/settings.pb.dart';
import 'package:brie/gen/user/v1/user.pb.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabIndexNotifier extends Notifier<int> {
  @override
  int build() => kDebugMode ? 4 : 0;

  void set(int newIndex) => state = newIndex;
}

final settingsTabIndexProvider = NotifierProvider<TabIndexNotifier, int>(
  TabIndexNotifier.new,
);

final isAdminProvider = FutureProvider<bool>((ref) async {
  final userData = await ref.watch(userInfoProvider.future);
  return userData.role == Role.Admin;
});

extension ConfigUpdateExtension on WidgetRef {
  void serverUpdateConfig(GoudaConfig Function(GoudaConfig) update) {
    read(serverConfigProvider.notifier).updateConfigField(update);
  }

  GoudaConfig serverGetConfig() {
    return read(serverConfigProvider).requireValue;
  }
}

extension ConfigUpdateExtension2 on Ref {
  GoudaConfig serverGetConfig() {
    return read(serverConfigProvider).requireValue;
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

  void updateConfigField(
    GoudaConfig Function(GoudaConfig existingConfig) updateConfig,
  ) {
    final curConfig = state.value!.deepCopy();
    final newConfig = updateConfig(curConfig);

    // logger.d("Updating config: $config");
    state = AsyncValue.data(newConfig);
  }
}
