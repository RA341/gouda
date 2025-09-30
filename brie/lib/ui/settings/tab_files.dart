import 'package:brie/clients/settings_api.dart';
import 'package:brie/gen/settings/v1/settings.pb.dart';
import 'package:brie/ui/settings/provider.dart';
import 'package:brie/ui/settings/utils.dart';
import 'package:brie/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TabFiles extends HookConsumerWidget {
  const TabFiles({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final curConfig = ref
        .watch(serverConfigProvider)
        .value!;
    final curPath = curConfig.dir;
    final perms = curConfig.permissions;

    final gidController = useTextEditingController(text: perms.gid.toString());
    final uidController = useTextEditingController(text: perms.uid.toString());

    final downloadsDirController = useTextEditingController(
      text: curPath.downloadDir,
    );
    final completeDirController = useTextEditingController(
      text: curPath.completeDir,
    );
    final torrentDirController = useTextEditingController(
      text: curPath.torrentDir,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 20),
      child: Column(
        spacing: 20,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingsField(
            controller: gidController,
            labelText: 'GID',
            onChanged: (value) {
              ref
                  .read(serverConfigProvider.notifier)
                  .updateConfigField(
                    (existingConfig) =>
                    existingConfig..permissions.gid = int.parse(value),
              );
            },
            helpText: "GID for files. Learn more.",
            clickableLinks: const [
              ClickableLink(
                text: "Learn more",
                url: "https://example.com/docs",
              ),
            ],
          ),
          SettingsField(
            controller: uidController,
            labelText: 'UID',
            helpText: "UID for files. Learn more.",
            clickableLinks: const [
              ClickableLink(
                text: "Learn more",
                // todo update docs urls
                url: "https://example.com/docs",
              ),
            ],
            onChanged: (value) {
              ref
                  .read(serverConfigProvider.notifier)
                  .updateConfigField(
                    (existingConfig) =>
                    existingConfig..permissions.uid = int.parse(value),
              );
            },
          ),
          const Divider(height: 20),

          SizedBox(
            width: 600,
            child: Row(
              spacing: 5,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {},
                    readOnly: true,
                    controller: downloadsDirController,
                    decoration: const InputDecoration(
                      label: Text("Download Dir"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    await onClick(context, downloadsDirController);
                    ref
                        .read(serverConfigProvider.notifier)
                        .updateConfigField(
                          (existingConfig) =>
                          existingConfig
                            ..dir.downloadDir = downloadsDirController.text,
                    );
                  },

                  icon: const Icon(Icons.create_new_folder),
                  label: const Text("Change"),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 600,
            child: Row(
              spacing: 5,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {},
                    readOnly: true,
                    controller: completeDirController,
                    decoration: const InputDecoration(
                      label: Text("Complete Dir"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    await onClick(context, completeDirController);
                    ref
                        .read(serverConfigProvider.notifier)
                        .updateConfigField(
                          (existingConfig) =>
                          existingConfig
                            ..dir.completeDir = completeDirController.text,
                    );
                  },

                  icon: const Icon(Icons.create_new_folder),
                  label: const Text("Change"),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 600,
            child: Row(
              spacing: 5,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {},
                    readOnly: true,
                    controller: torrentDirController,
                    decoration: const InputDecoration(
                      label: Text("Torrent Dir"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    await onClick(context, torrentDirController);
                    ref
                        .read(serverConfigProvider.notifier)
                        .updateConfigField(
                          (existingConfig) =>
                          existingConfig
                            ..dir.torrentDir = torrentDirController.text,
                    );
                  },
                  icon: const Icon(Icons.create_new_folder),
                  label: const Text("Change"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> onClick(BuildContext context,
      TextEditingController completeDirController,) async {
    final selectedPath = await showDialog<String>(
      context: context,
      builder: (context) =>
          FilePicker(
            controller: completeDirController,
            initialPath: completeDirController.text,
          ),
    );

    // Update the controller if a path was selected
    if (selectedPath != null) {
      completeDirController.text = selectedPath;
    }
  }
}

// The internal type is not exported by riverpod
// ignore: specify_nonobvious_property_types
final directoryListingsProvider =
FutureProvider.family<ListDirectoriesResponse, String>((ref,
    path,) async {
  final settingsApi = ref.read(settingsApiProvider);
  logger.d("getting path $path");

  return await settingsApi.listDirectories(
    ListDirectoriesRequest(filePath: path),
  );
});

class FilePicker extends HookConsumerWidget {
  const FilePicker({
    required this.controller,
    required this.initialPath,
    super.key,
  });

  final TextEditingController controller;
  final String initialPath;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPath = useState<String>(initialPath);
    final pathHistory = useState<List<String>>([]);

    final directoryListings = ref.watch(
      directoryListingsProvider(currentPath.value),
    );

    void navigateToPath(String newPath) {
      pathHistory.value = [...pathHistory.value, currentPath.value];
      currentPath.value = newPath;
    }

    void navigateBack() {
      if (pathHistory.value.isNotEmpty) {
        currentPath.value = pathHistory.value.last;
        pathHistory.value = pathHistory.value.sublist(
          0,
          pathHistory.value.length - 1,
        );
      }
    }

    void navigateUp() {
      final split = currentPath.value.split("/");
      final parent = split.sublist(0, split.length - 1).join("/");

      if (parent == "") {
        navigateToPath("/");
        return;
      }

      if (parent != currentPath.value) {
        navigateToPath(parent);
      }
    }

    return Dialog(
      child: Container(
        width: 700,
        height: 700,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select Directory',
                  style: Theme
                      .of(context)
                      .textTheme
                      .headlineSmall,
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const Divider(),

            // Navigation controls
            Row(
              children: [
                IconButton(
                  onPressed: pathHistory.value.isNotEmpty ? navigateBack : null,
                  icon: const Icon(Icons.arrow_back),
                  tooltip: 'Back',
                ),
                IconButton(
                  onPressed: navigateUp,
                  icon: const Icon(Icons.arrow_upward),
                  tooltip: 'Up one level',
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      currentPath.value,
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Expanded(
              child: directoryListings.when(
                loading: () =>
                const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, stackTrace) =>
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 48,
                            color: Theme
                                .of(context)
                                .colorScheme
                                .error,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Error loading directory',
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            error.toString(),
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodySmall,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              ref.invalidate(
                                directoryListingsProvider(currentPath.value),
                              );
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                data: (response) {
                  final folders = response.folders.toList();
                  final files = response.files.toList();
                  final isEmpty = folders.isEmpty && files.isEmpty;

                  if (isEmpty) {
                    return const Center(
                      child: Text('Empty folder'),
                    );
                  }

                  return ListView.builder(
                    itemCount: folders.length + files.length,
                    itemBuilder: (context, index) {
                      final isFolder = index < folders.length;
                      final itemName = isFolder
                          ? folders[index]
                          : files[index - folders.length];

                      // Construct full path
                      final fullPath = itemName;

                      return ListTile(
                        leading: Icon(
                          isFolder ? Icons.folder : Icons.insert_drive_file,
                          color: isFolder ? Colors.blue : Colors.grey,
                        ),
                        title: Text(itemName),
                        onTap: isFolder ? () => navigateToPath(fullPath) : null,
                        trailing: isFolder
                            ? IconButton(
                          icon: const Icon(Icons.check),
                          onPressed: () {
                            Navigator.of(context).pop(fullPath);
                          },
                          tooltip: 'Select this directory',
                        )
                            : null,
                      );
                    },
                  );
                },
              ),
            ),

            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Current: ${currentPath.value}',
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(currentPath.value);
                      },
                      child: const Text('Select Current'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
