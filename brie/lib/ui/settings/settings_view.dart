import 'package:brie/clients/user_api.dart';
import 'package:brie/ui/layout/layout_page.dart';
import 'package:brie/ui/settings/tab_account.dart';
import 'package:brie/ui/settings/tab_mam.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TabIndexNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void set(int newIndex) => state = newIndex;
}

final settingsTabIndexProvider = NotifierProvider<TabIndexNotifier, int>(
  TabIndexNotifier.new,
);

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoProvider);

    return Center(
      child: userInfo.when(
        data: (data) {
          final userInfo = ref.watch(userInfoProvider);
          final allSettings = <((String, IconData), Widget)>[
            (
            const (
            'Account',
            Icons.account_circle,
            ),
            const TabAccount(),
            ),
          ];

          final isAdmin = userInfo.value!.role == "admin";
          if (isAdmin) {
            final adminPages = [
              (
              const (
              'Mam',
              Icons.mouse,
              ),
              const TabMam(),
              ),
            ];

            allSettings.addAll(adminPages);
          }

          return isMobileView(context)
              ? SettingsCoreMobile(allSettings: allSettings)
              : SettingsCoreDesktop(allSettings: allSettings);
        },
        error: (error, stackTrace) => Text('Error $error'),
        loading: CircularProgressIndicator.new,
      ),
    );
  }
}

class SettingsCoreDesktop extends HookConsumerWidget {
  const SettingsCoreDesktop({required this.allSettings, super.key});

  final List<((String, IconData), Widget)> allSettings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final curTab = ref.watch(settingsTabIndexProvider);

    return Row(
      children: [
        Expanded(
          child: ColoredBox(
            color: Theme
                .of(context)
                .hoverColor
                .withAlpha(8),
            child: ListView.builder(
              itemCount: allSettings.length,
              itemBuilder: (context, index) =>
                  ListTile(
                    selected: index == curTab,
                    selectedTileColor: Colors.blue.withValues(alpha: 0.1),

                    leading: Icon(allSettings[index].$1.$2),
                    title: Text(allSettings[index].$1.$1),
                    onTap: () =>
                        ref.read(settingsTabIndexProvider.notifier).set(index),
                  ),
            ),
          ),
        ),
        Expanded(flex: 5, child: allSettings[curTab].$2),
      ],
    );
  }
}

class SettingsCoreMobile extends HookConsumerWidget {
  const SettingsCoreMobile({required this.allSettings, super.key});

  final List<((String, IconData), Widget)> allSettings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabHeaders = allSettings
        .map((e) => Tab(icon: Icon(e.$1.$2), text: e.$1.$1))
        .toList();
    final pages = allSettings.map((e) => e.$2).toList();

    final curTab = ref.watch(settingsTabIndexProvider);
    final tabController = useTabController(
      initialLength: allSettings.length,
      initialIndex: curTab,
    );

    return Column(
      children: [
        ColoredBox(
          color: Theme
              .of(context)
              .hoverColor
              .withAlpha(8),
          child: TabBar(
            onTap: ref
                .read(settingsTabIndexProvider.notifier)
                .set,
            controller: tabController,
            tabs: tabHeaders,

            tabAlignment: TabAlignment.center,
            isScrollable: true,

            indicator: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(8),
              color: Colors.blue.withValues(alpha: 0.1),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: const EdgeInsets.all(2),
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey[600],
            dividerColor: Colors.transparent,
            labelStyle: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: pages,
          ),
        ),
      ],
    );
  }
}
