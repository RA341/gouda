export 'package:brie/grpc/grpc_channel_stub.dart' // Stub implementation
    if (dart.library.io) 'package:brie/grpc/grpc_channel_native.dart' // dart:io implementation
    if (dart.library.js_interop) 'package:brie/grpc/grpc_channel_web.dart'; // package:web implementation
