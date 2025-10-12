//
//  Generated code. Do not modify.
//  source: user/v1/user.proto
//

import "package:connectrpc/connect.dart" as connect;
import "user.pb.dart" as userv1user;

abstract final class UserService {
  /// Fully-qualified name of the UserService service.
  static const name = 'user.v1.UserService';

  static const userList = connect.Spec(
    '/$name/UserList',
    connect.StreamType.unary,
    userv1user.ListUsersRequest.new,
    userv1user.ListUsersResponse.new,
  );

  static const userAdd = connect.Spec(
    '/$name/UserAdd',
    connect.StreamType.unary,
    userv1user.AddUserRequest.new,
    userv1user.AddUserResponse.new,
  );

  static const userDelete = connect.Spec(
    '/$name/UserDelete',
    connect.StreamType.unary,
    userv1user.UserDeleteRequest.new,
    userv1user.UserDeleteResponse.new,
  );

  static const userEdit = connect.Spec(
    '/$name/UserEdit',
    connect.StreamType.unary,
    userv1user.UserEditRequest.new,
    userv1user.UserEditResponse.new,
  );
}
