//
//  Generated code. Do not modify.
//  source: user/v1/user.proto
//

import "package:connectrpc/connect.dart" as connect;
import "user.pb.dart" as userv1user;
import "user.connect.spec.dart" as specs;

extension type UserServiceClient (connect.Transport _transport) {
  Future<userv1user.GetUserInfoResponse> getUserInfo(
      userv1user.GetUserInfoRequest input, {
        connect.Headers? headers,
        connect.AbortSignal? signal,
        Function(connect.Headers)? onHeader,
        Function(connect.Headers)? onTrailer,
      }) {
    return connect.Client(_transport).unary(
      specs.UserService.getUserInfo,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }
}
