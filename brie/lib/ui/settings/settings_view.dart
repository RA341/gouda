import 'package:brie/clients/user_api.dart';
import 'package:brie/ui/layout/layout_page.dart';
import 'package:brie/ui/settings/provider.dart';
import 'package:brie/ui/settings/settings_model.dart';
import 'package:brie/ui/settings/tab_account.dart';
import 'package:brie/ui/settings/tab_mam.dart';
import 'package:brie/ui/shared/error_dialog.dart';
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

final isAdminProvider = FutureProvider<bool>((ref) async {
  final userData = await ref.watch(userInfoProvider.future);
  return userData.role == "admin";
});

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adminCheck = ref.watch(isAdminProvider);

    return Center(
      child: adminCheck.when(
        data: (isAdmin) {
          final allSettings = <SettingsPageConfig>[
            SettingsPageConfig(
              title: 'Account',
              iconData: Icons.account_circle,
              child: const TabAccount(),
            ),
          ];

          if (isAdmin) {
            final adminPages = [
              SettingsPageConfig(
                title: 'Mam',
                iconData: Icons.mouse,
                child: const ServerSettingsView(child: TabMam()),
                buttons: [
                  IconLabelButton(
                    onTap: () async {
                      await ref
                          .read(serverConfigProvider.notifier)
                          .saveConfig();
                    },
                    label: "Save",
                    icon: Icons.save,
                    isRefreshing: ref.watch(serverConfigProvider).isLoading,
                  ),
                ],
              ),
            ];

            allSettings.addAll(adminPages);
          }

          return isMobileView(context)
              ? SettingsCoreMobile(pages: allSettings)
              : SettingsCoreDesktop(pages: allSettings);
        },
        error: (error, stackTrace) => Text('Error $error'),
        loading: CircularProgressIndicator.new,
      ),
    );
  }
}

class SettingsCoreDesktop extends HookConsumerWidget {
  const SettingsCoreDesktop({required this.pages, super.key});

  final List<SettingsPageConfig> pages;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final curTab = ref.watch(settingsTabIndexProvider);

    return Row(
      children: [
        Expanded(
          child: ColoredBox(
            color: Theme.of(context).hoverColor.withAlpha(8),
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ListView.builder(
                itemCount: pages.length,
                itemBuilder: (context, index) => ListTile(
                  selected: index == curTab,
                  selectedTileColor: Colors.blue.withValues(alpha: 0.1),

                  leading: Icon(pages[index].iconData),
                  title: Text(pages[index].title),
                  onTap: () =>
                      ref.read(settingsTabIndexProvider.notifier).set(index),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Column(
            children: [
              if (pages[curTab].buttons.isNotEmpty)
                SettingsActionBar(config: pages[curTab]),
              pages[curTab].child,
            ],
          ),
        ),
      ],
    );
  }
}

class SettingsCoreMobile extends HookConsumerWidget {
  const SettingsCoreMobile({required this.pages, super.key});

  final List<SettingsPageConfig> pages;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabHeaders = pages
        .map((e) => Tab(icon: Icon(e.iconData), text: e.title))
        .toList();

    final settingPages = pages.map((e) => e.child).toList();

    final curTab = ref.watch(settingsTabIndexProvider);
    final tabController = useTabController(
      initialLength: pages.length,
      initialIndex: curTab,
    );

    return Column(
      children: [
        ColoredBox(
          color: Theme.of(context).hoverColor.withAlpha(8),
          child: TabBar(
            onTap: ref.read(settingsTabIndexProvider.notifier).set,
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
          child: Column(
            children: [
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: settingPages,
                ),
              ),
              if (pages[curTab].buttons.isNotEmpty)
                SettingsActionBar(
                  config: pages[curTab],
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class SettingsActionBar extends ConsumerWidget {
  const SettingsActionBar({required this.config, super.key});

  final SettingsPageConfig config;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ColoredBox(
      color: Theme.of(context).hoverColor,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          spacing: 10,
          children: config.buttons,
        ),
      ),
    );
  }
}

class IconLabelButton extends ConsumerWidget {
  const IconLabelButton({
    required this.onTap,
    required this.icon,
    required this.label,
    this.isRefreshing = false,
    super.key,
  });

  final bool isRefreshing;
  final void Function() onTap;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final iconColor = Theme.of(context).iconTheme.color;
    final textColor = Theme.of(context).textTheme.bodyMedium?.color;
    return InkWell(
      onTap: isRefreshing ? null : onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: isRefreshing ? iconColor?.withAlpha(30) : iconColor,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isRefreshing ? iconColor?.withAlpha(30) : textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServerSettingsView extends ConsumerWidget {
  const ServerSettingsView({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(serverConfigProvider);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: config.when(
        data: (data) => child,
        error: (error, stackTrace) => Align(
          child: ErrorDisplay(message: error.toString()),
        ),
        loading: LoadingSpinner.new,
      ),
    );
  }
}
