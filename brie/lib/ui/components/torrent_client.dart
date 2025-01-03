import 'package:brie/config.dart';
import 'package:brie/ui/components/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TorrentClientInput extends ConsumerWidget {
  const TorrentClientInput({
    required this.torrentUsername,
    required this.torrentPassword,
    required this.torrentUrl,
    required this.torrentClientType,
    required this.torrentProtocol,
    super.key,
  });

  static const paddingWidth = 10.0;

  final TextEditingController torrentUsername;
  final TextEditingController torrentPassword;
  final TextEditingController torrentUrl;
  final ValueNotifier<String> torrentClientType;
  final ValueNotifier<String> torrentProtocol;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 800,
      height: 250,
      decoration: BoxDecoration(
        color: Theme.of(context).focusColor,
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [Colors.lightGreenAccent, Colors.greenAccent],
        ),
      ),
      child: Column(
        children: [
          Text(
            'Torrent client settings',
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(
            width: 700,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Divider(thickness: 4),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: paddingWidth),
                  child: createDropDown2(
                      supportedClients, torrentClientType, 'Client type'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: paddingWidth),
                  child: createDropDown2(
                      supportedProtocols, torrentProtocol, 'Protocol'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: paddingWidth),
                  child: SizedBox(
                    width: 275,
                    child: createUpdateButtons2(
                      'URL',
                      torrentUrl,
                      hintText: 'localhost:8080, qbit.ex.com',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: AutofillGroup(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: userPassWidth,
                    child: createUpdateButtons2(
                      'Username',
                      torrentUsername,
                      autofillHints: [AutofillHints.username],
                    ),
                  ),
                  SizedBox(width: 25),
                  SizedBox(
                    width: userPassWidth,
                    child: createUpdateButtons2(
                      'Password',
                      torrentPassword,
                      autofillHints: [AutofillHints.password],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static final userPassWidth = 300.0;
}
