import 'package:grpc/grpc.dart';

typedef Channel = ClientChannel;

Channel setupClientChannel(String basePath) {
  final split = Uri.parse(basePath);
  return ClientChannel(
    split.host,
    port: split.port,
    options: ChannelOptions(
      credentials: split.scheme == 'https'
          ? ChannelCredentials.secure()
          : ChannelCredentials.insecure(),
    ),
  );
}
