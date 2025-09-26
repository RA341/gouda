import 'package:brie/utils.dart';
import 'package:grpc/grpc_web.dart';
import 'package:web/web.dart';

String getWindowUrl() {
  return window.location.toString();
}

typedef Channel = GrpcWebClientChannel;

Channel setupClientChannel(String basePath) {
  logger.i('using Web channel');

  var bas = basePath;

  if (bas.isEmpty) {
    bas = window.location.toString();
  }

  logger.i('using base path $bas');

  return GrpcWebClientChannel.xhr(Uri.parse(bas));
}
