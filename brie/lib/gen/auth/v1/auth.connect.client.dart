//
//  Generated code. Do not modify.
//  source: auth/v1/auth.proto
//

import "package:connectrpc/connect.dart" as connect;
import "auth.pb.dart" as authv1auth;
import "auth.connect.spec.dart" as specs;

extension type AuthServiceClient (connect.Transport _transport) {
  Future<authv1auth.LoginResponse> login(authv1auth.LoginRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.AuthService.login,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<authv1auth.LogoutResponse> logout(authv1auth.LogoutRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.AuthService.logout,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<authv1auth.RegisterResponse> register(authv1auth.RegisterRequest input,
      {
        connect.Headers? headers,
        connect.AbortSignal? signal,
        Function(connect.Headers)? onHeader,
        Function(connect.Headers)? onTrailer,
      }) {
    return connect.Client(_transport).unary(
      specs.AuthService.register,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<authv1auth.VerifySessionResponse> verifySession(
      authv1auth.VerifySessionRequest input, {
        connect.Headers? headers,
        connect.AbortSignal? signal,
        Function(connect.Headers)? onHeader,
        Function(connect.Headers)? onTrailer,
      }) {
    return connect.Client(_transport).unary(
      specs.AuthService.verifySession,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<authv1auth.RefreshSessionResponse> refreshSession(
      authv1auth.RefreshSessionRequest input, {
        connect.Headers? headers,
        connect.AbortSignal? signal,
        Function(connect.Headers)? onHeader,
        Function(connect.Headers)? onTrailer,
      }) {
    return connect.Client(_transport).unary(
      specs.AuthService.refreshSession,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }
}
