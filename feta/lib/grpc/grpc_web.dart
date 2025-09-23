import 'package:grpc/grpc_web.dart';
import 'package:universal_html/html.dart' as html;

typedef Channel = GrpcWebClientChannel;

Channel setupClientChannel(String basePath) {
  if (basePath.isEmpty) {
    basePath = html.window.location.toString();
  }

  return GrpcWebClientChannel.xhr(Uri.parse(basePath));
}
