import 'package:brie/utils.dart';
import 'package:grpc/grpc.dart';

typedef Channel = ClientChannel;

Channel setupClientChannel(String basePath) {
  logger.d('using native channel');

  final split = Uri.parse(basePath);
  return ClientChannel(
    split.host,
    port: split.port,
    options: ChannelOptions(
      credentials: split.scheme == 'https'
          ? const ChannelCredentials.secure()
          : const ChannelCredentials.insecure(),
    ),
  );
}
