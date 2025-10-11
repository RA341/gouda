// This is a generated file - do not edit.
//
// Generated from mam/v1/mam.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'mam.pb.dart' as $0;
import 'mam.pbjson.dart';

export 'mam.pb.dart';

abstract class MamServiceBase extends $pb.GeneratedService {
  $async.Future<$0.SearchResults> search($pb.ServerContext ctx,
      $0.Query request);

  $async.Future<$0.VipResponse> buyVip($pb.ServerContext ctx,
      $0.VipRequest request);

  $async.Future<$0.GetThumbnailResponse> getThumbnail($pb.ServerContext ctx,
      $0.GetThumbnailRequest request);

  $async.Future<$0.UserData> getProfile($pb.ServerContext ctx,
      $0.Empty request);

  $async.Future<$0.BonusResponse> buyBonus($pb.ServerContext ctx,
      $0.BonusRequest request);

  $async.Future<$0.IsMamSetupResponse> isMamSetup($pb.ServerContext ctx,
      $0.IsMamSetupRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'Search':
        return $0.Query();
      case 'BuyVip':
        return $0.VipRequest();
      case 'GetThumbnail':
        return $0.GetThumbnailRequest();
      case 'GetProfile':
        return $0.Empty();
      case 'BuyBonus':
        return $0.BonusRequest();
      case 'IsMamSetup':
        return $0.IsMamSetupRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'Search':
        return search(ctx, request as $0.Query);
      case 'BuyVip':
        return buyVip(ctx, request as $0.VipRequest);
      case 'GetThumbnail':
        return getThumbnail(ctx, request as $0.GetThumbnailRequest);
      case 'GetProfile':
        return getProfile(ctx, request as $0.Empty);
      case 'BuyBonus':
        return buyBonus(ctx, request as $0.BonusRequest);
      case 'IsMamSetup':
        return isMamSetup(ctx, request as $0.IsMamSetupRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => MamServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
  get $messageJson => MamServiceBase$messageJson;
}
