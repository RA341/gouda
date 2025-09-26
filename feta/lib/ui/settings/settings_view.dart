import 'package:feta/ui/layout/layout_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mob = isMobileView(context);

    return Center(
      child: Text(mob ? 'Mobile Settings view' : 'Desktop Settings view'),
    );
  }
}
