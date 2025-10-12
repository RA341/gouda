//
//  Generated code. Do not modify.
//  source: auth/v1/auth.proto
//

import "package:connectrpc/connect.dart" as connect;
import "auth.pb.dart" as authv1auth;

abstract final class AuthService {
  /// Fully-qualified name of the AuthService service.
  static const name = 'auth.v1.AuthService';

  static const login = connect.Spec(
    '/$name/Login',
    connect.StreamType.unary,
    authv1auth.LoginRequest.new,
    authv1auth.LoginResponse.new,
  );

  static const logout = connect.Spec(
    '/$name/Logout',
    connect.StreamType.unary,
    authv1auth.LogoutRequest.new,
    authv1auth.LogoutResponse.new,
  );

  static const userProfile = connect.Spec(
    '/$name/UserProfile',
    connect.StreamType.unary,
    authv1auth.UserProfileRequest.new,
    authv1auth.UserProfileResponse.new,
  );

  static const verifySession = connect.Spec(
    '/$name/VerifySession',
    connect.StreamType.unary,
    authv1auth.VerifySessionRequest.new,
    authv1auth.VerifySessionResponse.new,
  );

  static const refreshSession = connect.Spec(
    '/$name/RefreshSession',
    connect.StreamType.unary,
    authv1auth.RefreshSessionRequest.new,
    authv1auth.RefreshSessionResponse.new,
  );
}
