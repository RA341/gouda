// This is a generated file - do not edit.
//
// Generated from mam/v1/mam.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class UserData extends $pb.GeneratedMessage {
  factory UserData({
    $core.String? classname,
    $core.String? countryCode,
    $core.String? countryName,
    $core.String? downloaded,
    $fixnum.Int64? downloadedBytes,
    $core.double? ratio,
    $core.int? seedbonus,
    $core.int? uid,
    $core.String? uploaded,
    $fixnum.Int64? uploadedBytes,
    $core.String? username,
    $core.String? vipUntil,
  }) {
    final result = create();
    if (classname != null) result.classname = classname;
    if (countryCode != null) result.countryCode = countryCode;
    if (countryName != null) result.countryName = countryName;
    if (downloaded != null) result.downloaded = downloaded;
    if (downloadedBytes != null) result.downloadedBytes = downloadedBytes;
    if (ratio != null) result.ratio = ratio;
    if (seedbonus != null) result.seedbonus = seedbonus;
    if (uid != null) result.uid = uid;
    if (uploaded != null) result.uploaded = uploaded;
    if (uploadedBytes != null) result.uploadedBytes = uploadedBytes;
    if (username != null) result.username = username;
    if (vipUntil != null) result.vipUntil = vipUntil;
    return result;
  }

  UserData._();

  factory UserData.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserData.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserData',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mam.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'classname')
    ..aOS(2, _omitFieldNames ? '' : 'countryCode')
    ..aOS(3, _omitFieldNames ? '' : 'countryName')
    ..aOS(4, _omitFieldNames ? '' : 'downloaded')
    ..aInt64(5, _omitFieldNames ? '' : 'downloadedBytes')
    ..a<$core.double>(6, _omitFieldNames ? '' : 'ratio', $pb.PbFieldType.OD)
    ..a<$core.int>(7, _omitFieldNames ? '' : 'seedbonus', $pb.PbFieldType.O3)
    ..a<$core.int>(8, _omitFieldNames ? '' : 'uid', $pb.PbFieldType.O3)
    ..aOS(9, _omitFieldNames ? '' : 'uploaded')
    ..aInt64(10, _omitFieldNames ? '' : 'uploadedBytes')
    ..aOS(11, _omitFieldNames ? '' : 'username')
    ..aOS(12, _omitFieldNames ? '' : 'vipUntil')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserData clone() => UserData()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserData copyWith(void Function(UserData) updates) =>
      super.copyWith((message) => updates(message as UserData)) as UserData;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserData create() => UserData._();
  @$core.override
  UserData createEmptyInstance() => create();
  static $pb.PbList<UserData> createRepeated() => $pb.PbList<UserData>();
  @$core.pragma('dart2js:noInline')
  static UserData getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserData>(create);
  static UserData? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get classname => $_getSZ(0);
  @$pb.TagNumber(1)
  set classname($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasClassname() => $_has(0);
  @$pb.TagNumber(1)
  void clearClassname() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get countryCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set countryCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCountryCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCountryCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get countryName => $_getSZ(2);
  @$pb.TagNumber(3)
  set countryName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCountryName() => $_has(2);
  @$pb.TagNumber(3)
  void clearCountryName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get downloaded => $_getSZ(3);
  @$pb.TagNumber(4)
  set downloaded($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDownloaded() => $_has(3);
  @$pb.TagNumber(4)
  void clearDownloaded() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get downloadedBytes => $_getI64(4);
  @$pb.TagNumber(5)
  set downloadedBytes($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDownloadedBytes() => $_has(4);
  @$pb.TagNumber(5)
  void clearDownloadedBytes() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get ratio => $_getN(5);
  @$pb.TagNumber(6)
  set ratio($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasRatio() => $_has(5);
  @$pb.TagNumber(6)
  void clearRatio() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get seedbonus => $_getIZ(6);
  @$pb.TagNumber(7)
  set seedbonus($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasSeedbonus() => $_has(6);
  @$pb.TagNumber(7)
  void clearSeedbonus() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get uid => $_getIZ(7);
  @$pb.TagNumber(8)
  set uid($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasUid() => $_has(7);
  @$pb.TagNumber(8)
  void clearUid() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get uploaded => $_getSZ(8);
  @$pb.TagNumber(9)
  set uploaded($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasUploaded() => $_has(8);
  @$pb.TagNumber(9)
  void clearUploaded() => $_clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get uploadedBytes => $_getI64(9);
  @$pb.TagNumber(10)
  set uploadedBytes($fixnum.Int64 value) => $_setInt64(9, value);
  @$pb.TagNumber(10)
  $core.bool hasUploadedBytes() => $_has(9);
  @$pb.TagNumber(10)
  void clearUploadedBytes() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get username => $_getSZ(10);
  @$pb.TagNumber(11)
  set username($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasUsername() => $_has(10);
  @$pb.TagNumber(11)
  void clearUsername() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get vipUntil => $_getSZ(11);
  @$pb.TagNumber(12)
  set vipUntil($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasVipUntil() => $_has(11);
  @$pb.TagNumber(12)
  void clearVipUntil() => $_clearField(12);
}

class VipRequest extends $pb.GeneratedMessage {
  factory VipRequest({
    $core.int? amountInWeeks,
  }) {
    final result = create();
    if (amountInWeeks != null) result.amountInWeeks = amountInWeeks;
    return result;
  }

  VipRequest._();

  factory VipRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VipRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VipRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mam.v1'),
      createEmptyInstance: create)
    ..a<$core.int>(
        1, _omitFieldNames ? '' : 'amountInWeeks', $pb.PbFieldType.O3,
        protoName: 'amountInWeeks')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VipRequest clone() => VipRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VipRequest copyWith(void Function(VipRequest) updates) =>
      super.copyWith((message) => updates(message as VipRequest)) as VipRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VipRequest create() => VipRequest._();
  @$core.override
  VipRequest createEmptyInstance() => create();
  static $pb.PbList<VipRequest> createRepeated() => $pb.PbList<VipRequest>();
  @$core.pragma('dart2js:noInline')
  static VipRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VipRequest>(create);
  static VipRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get amountInWeeks => $_getIZ(0);
  @$pb.TagNumber(1)
  set amountInWeeks($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAmountInWeeks() => $_has(0);
  @$pb.TagNumber(1)
  void clearAmountInWeeks() => $_clearField(1);
}

class VipResponse extends $pb.GeneratedMessage {
  factory VipResponse({
    $core.bool? success,
    $core.String? type,
    $core.double? amount,
    $core.double? seedBonus,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (type != null) result.type = type;
    if (amount != null) result.amount = amount;
    if (seedBonus != null) result.seedBonus = seedBonus;
    return result;
  }

  VipResponse._();

  factory VipResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VipResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VipResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mam.v1'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'Success', protoName: 'Success')
    ..aOS(2, _omitFieldNames ? '' : 'Type', protoName: 'Type')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'Amount', $pb.PbFieldType.OF,
        protoName: 'Amount')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'SeedBonus', $pb.PbFieldType.OF,
        protoName: 'SeedBonus')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VipResponse clone() => VipResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VipResponse copyWith(void Function(VipResponse) updates) =>
      super.copyWith((message) => updates(message as VipResponse))
          as VipResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VipResponse create() => VipResponse._();
  @$core.override
  VipResponse createEmptyInstance() => create();
  static $pb.PbList<VipResponse> createRepeated() => $pb.PbList<VipResponse>();
  @$core.pragma('dart2js:noInline')
  static VipResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VipResponse>(create);
  static VipResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get type => $_getSZ(1);
  @$pb.TagNumber(2)
  set type($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double value) => $_setFloat(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get seedBonus => $_getN(3);
  @$pb.TagNumber(4)
  set seedBonus($core.double value) => $_setFloat(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSeedBonus() => $_has(3);
  @$pb.TagNumber(4)
  void clearSeedBonus() => $_clearField(4);
}

class BonusRequest extends $pb.GeneratedMessage {
  factory BonusRequest({
    $core.int? amountInGB,
  }) {
    final result = create();
    if (amountInGB != null) result.amountInGB = amountInGB;
    return result;
  }

  BonusRequest._();

  factory BonusRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BonusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BonusRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mam.v1'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'amountInGB', $pb.PbFieldType.O3,
        protoName: 'amountInGB')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BonusRequest clone() => BonusRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BonusRequest copyWith(void Function(BonusRequest) updates) =>
      super.copyWith((message) => updates(message as BonusRequest))
          as BonusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BonusRequest create() => BonusRequest._();
  @$core.override
  BonusRequest createEmptyInstance() => create();
  static $pb.PbList<BonusRequest> createRepeated() =>
      $pb.PbList<BonusRequest>();
  @$core.pragma('dart2js:noInline')
  static BonusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BonusRequest>(create);
  static BonusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get amountInGB => $_getIZ(0);
  @$pb.TagNumber(1)
  set amountInGB($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAmountInGB() => $_has(0);
  @$pb.TagNumber(1)
  void clearAmountInGB() => $_clearField(1);
}

class BonusResponse extends $pb.GeneratedMessage {
  factory BonusResponse({
    $core.bool? success,
    $core.String? type,
    $core.double? amount,
    $core.double? seedbonus,
    $fixnum.Int64? uploaded,
    $fixnum.Int64? downloaded,
    $core.String? uploadFancy,
    $core.String? downloadFancy,
    $core.double? ratio,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (type != null) result.type = type;
    if (amount != null) result.amount = amount;
    if (seedbonus != null) result.seedbonus = seedbonus;
    if (uploaded != null) result.uploaded = uploaded;
    if (downloaded != null) result.downloaded = downloaded;
    if (uploadFancy != null) result.uploadFancy = uploadFancy;
    if (downloadFancy != null) result.downloadFancy = downloadFancy;
    if (ratio != null) result.ratio = ratio;
    return result;
  }

  BonusResponse._();

  factory BonusResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BonusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BonusResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mam.v1'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'Success', protoName: 'Success')
    ..aOS(2, _omitFieldNames ? '' : 'Type', protoName: 'Type')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'Amount', $pb.PbFieldType.OF,
        protoName: 'Amount')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'Seedbonus', $pb.PbFieldType.OF,
        protoName: 'Seedbonus')
    ..aInt64(5, _omitFieldNames ? '' : 'Uploaded', protoName: 'Uploaded')
    ..aInt64(6, _omitFieldNames ? '' : 'Downloaded', protoName: 'Downloaded')
    ..aOS(7, _omitFieldNames ? '' : 'UploadFancy', protoName: 'UploadFancy')
    ..aOS(8, _omitFieldNames ? '' : 'DownloadFancy', protoName: 'DownloadFancy')
    ..a<$core.double>(9, _omitFieldNames ? '' : 'Ratio', $pb.PbFieldType.OF,
        protoName: 'Ratio')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BonusResponse clone() => BonusResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BonusResponse copyWith(void Function(BonusResponse) updates) =>
      super.copyWith((message) => updates(message as BonusResponse))
          as BonusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BonusResponse create() => BonusResponse._();
  @$core.override
  BonusResponse createEmptyInstance() => create();
  static $pb.PbList<BonusResponse> createRepeated() =>
      $pb.PbList<BonusResponse>();
  @$core.pragma('dart2js:noInline')
  static BonusResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BonusResponse>(create);
  static BonusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get type => $_getSZ(1);
  @$pb.TagNumber(2)
  set type($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double value) => $_setFloat(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get seedbonus => $_getN(3);
  @$pb.TagNumber(4)
  set seedbonus($core.double value) => $_setFloat(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSeedbonus() => $_has(3);
  @$pb.TagNumber(4)
  void clearSeedbonus() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get uploaded => $_getI64(4);
  @$pb.TagNumber(5)
  set uploaded($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasUploaded() => $_has(4);
  @$pb.TagNumber(5)
  void clearUploaded() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get downloaded => $_getI64(5);
  @$pb.TagNumber(6)
  set downloaded($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDownloaded() => $_has(5);
  @$pb.TagNumber(6)
  void clearDownloaded() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get uploadFancy => $_getSZ(6);
  @$pb.TagNumber(7)
  set uploadFancy($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasUploadFancy() => $_has(6);
  @$pb.TagNumber(7)
  void clearUploadFancy() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get downloadFancy => $_getSZ(7);
  @$pb.TagNumber(8)
  set downloadFancy($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasDownloadFancy() => $_has(7);
  @$pb.TagNumber(8)
  void clearDownloadFancy() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.double get ratio => $_getN(8);
  @$pb.TagNumber(9)
  set ratio($core.double value) => $_setFloat(8, value);
  @$pb.TagNumber(9)
  $core.bool hasRatio() => $_has(8);
  @$pb.TagNumber(9)
  void clearRatio() => $_clearField(9);
}

class SearchResults extends $pb.GeneratedMessage {
  factory SearchResults({
    $core.Iterable<Book>? results,
    $core.int? found,
    $core.int? total,
  }) {
    final result = create();
    if (results != null) result.results.addAll(results);
    if (found != null) result.found = found;
    if (total != null) result.total = total;
    return result;
  }

  SearchResults._();

  factory SearchResults.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchResults.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchResults',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mam.v1'),
      createEmptyInstance: create)
    ..pc<Book>(1, _omitFieldNames ? '' : 'results', $pb.PbFieldType.PM,
        subBuilder: Book.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'found', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchResults clone() => SearchResults()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchResults copyWith(void Function(SearchResults) updates) =>
      super.copyWith((message) => updates(message as SearchResults))
          as SearchResults;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchResults create() => SearchResults._();
  @$core.override
  SearchResults createEmptyInstance() => create();
  static $pb.PbList<SearchResults> createRepeated() =>
      $pb.PbList<SearchResults>();
  @$core.pragma('dart2js:noInline')
  static SearchResults getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchResults>(create);
  static SearchResults? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Book> get results => $_getList(0);

  /// total found
  @$pb.TagNumber(2)
  $core.int get found => $_getIZ(1);
  @$pb.TagNumber(2)
  set found($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFound() => $_has(1);
  @$pb.TagNumber(2)
  void clearFound() => $_clearField(2);

  /// total results
  @$pb.TagNumber(3)
  $core.int get total => $_getIZ(2);
  @$pb.TagNumber(3)
  set total($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotal() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotal() => $_clearField(3);
}

class Book extends $pb.GeneratedMessage {
  factory Book({
    $core.String? id,
    $core.String? title,
    $core.String? author,
    $core.String? format,
    $core.String? length,
    $core.String? torrentLink,
    $core.int? category,
    $core.String? thumbnail,
    $core.String? size,
    $core.int? seeders,
    $core.int? leechers,
    $core.String? added,
    $core.String? tags,
    $core.int? completed,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (title != null) result.title = title;
    if (author != null) result.author = author;
    if (format != null) result.format = format;
    if (length != null) result.length = length;
    if (torrentLink != null) result.torrentLink = torrentLink;
    if (category != null) result.category = category;
    if (thumbnail != null) result.thumbnail = thumbnail;
    if (size != null) result.size = size;
    if (seeders != null) result.seeders = seeders;
    if (leechers != null) result.leechers = leechers;
    if (added != null) result.added = added;
    if (tags != null) result.tags = tags;
    if (completed != null) result.completed = completed;
    return result;
  }

  Book._();

  factory Book.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Book.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Book',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mam.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'author')
    ..aOS(4, _omitFieldNames ? '' : 'format')
    ..aOS(5, _omitFieldNames ? '' : 'length')
    ..aOS(6, _omitFieldNames ? '' : 'torrentLink')
    ..a<$core.int>(7, _omitFieldNames ? '' : 'category', $pb.PbFieldType.O3)
    ..aOS(8, _omitFieldNames ? '' : 'thumbnail')
    ..aOS(9, _omitFieldNames ? '' : 'size')
    ..a<$core.int>(10, _omitFieldNames ? '' : 'seeders', $pb.PbFieldType.O3)
    ..a<$core.int>(11, _omitFieldNames ? '' : 'leechers', $pb.PbFieldType.O3)
    ..aOS(12, _omitFieldNames ? '' : 'added')
    ..aOS(13, _omitFieldNames ? '' : 'tags')
    ..a<$core.int>(14, _omitFieldNames ? '' : 'completed', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Book clone() => Book()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Book copyWith(void Function(Book) updates) =>
      super.copyWith((message) => updates(message as Book)) as Book;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Book create() => Book._();
  @$core.override
  Book createEmptyInstance() => create();
  static $pb.PbList<Book> createRepeated() => $pb.PbList<Book>();
  @$core.pragma('dart2js:noInline')
  static Book getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Book>(create);
  static Book? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get author => $_getSZ(2);
  @$pb.TagNumber(3)
  set author($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAuthor() => $_has(2);
  @$pb.TagNumber(3)
  void clearAuthor() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get format => $_getSZ(3);
  @$pb.TagNumber(4)
  set format($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFormat() => $_has(3);
  @$pb.TagNumber(4)
  void clearFormat() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get length => $_getSZ(4);
  @$pb.TagNumber(5)
  set length($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasLength() => $_has(4);
  @$pb.TagNumber(5)
  void clearLength() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get torrentLink => $_getSZ(5);
  @$pb.TagNumber(6)
  set torrentLink($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTorrentLink() => $_has(5);
  @$pb.TagNumber(6)
  void clearTorrentLink() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get category => $_getIZ(6);
  @$pb.TagNumber(7)
  set category($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCategory() => $_has(6);
  @$pb.TagNumber(7)
  void clearCategory() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get thumbnail => $_getSZ(7);
  @$pb.TagNumber(8)
  set thumbnail($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasThumbnail() => $_has(7);
  @$pb.TagNumber(8)
  void clearThumbnail() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get size => $_getSZ(8);
  @$pb.TagNumber(9)
  set size($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasSize() => $_has(8);
  @$pb.TagNumber(9)
  void clearSize() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.int get seeders => $_getIZ(9);
  @$pb.TagNumber(10)
  set seeders($core.int value) => $_setSignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasSeeders() => $_has(9);
  @$pb.TagNumber(10)
  void clearSeeders() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.int get leechers => $_getIZ(10);
  @$pb.TagNumber(11)
  set leechers($core.int value) => $_setSignedInt32(10, value);
  @$pb.TagNumber(11)
  $core.bool hasLeechers() => $_has(10);
  @$pb.TagNumber(11)
  void clearLeechers() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get added => $_getSZ(11);
  @$pb.TagNumber(12)
  set added($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasAdded() => $_has(11);
  @$pb.TagNumber(12)
  void clearAdded() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get tags => $_getSZ(12);
  @$pb.TagNumber(13)
  set tags($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasTags() => $_has(12);
  @$pb.TagNumber(13)
  void clearTags() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.int get completed => $_getIZ(13);
  @$pb.TagNumber(14)
  set completed($core.int value) => $_setSignedInt32(13, value);
  @$pb.TagNumber(14)
  $core.bool hasCompleted() => $_has(13);
  @$pb.TagNumber(14)
  void clearCompleted() => $_clearField(14);
}

class FreeLeechInfo extends $pb.GeneratedMessage {
  factory FreeLeechInfo({
    $core.String? type,
    $core.String? expires,
  }) {
    final result = create();
    if (type != null) result.type = type;
    if (expires != null) result.expires = expires;
    return result;
  }

  FreeLeechInfo._();

  factory FreeLeechInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FreeLeechInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FreeLeechInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mam.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'type')
    ..aOS(2, _omitFieldNames ? '' : 'expires')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FreeLeechInfo clone() => FreeLeechInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FreeLeechInfo copyWith(void Function(FreeLeechInfo) updates) =>
      super.copyWith((message) => updates(message as FreeLeechInfo))
          as FreeLeechInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FreeLeechInfo create() => FreeLeechInfo._();
  @$core.override
  FreeLeechInfo createEmptyInstance() => create();
  static $pb.PbList<FreeLeechInfo> createRepeated() =>
      $pb.PbList<FreeLeechInfo>();
  @$core.pragma('dart2js:noInline')
  static FreeLeechInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FreeLeechInfo>(create);
  static FreeLeechInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get type => $_getSZ(0);
  @$pb.TagNumber(1)
  set type($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get expires => $_getSZ(1);
  @$pb.TagNumber(2)
  set expires($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasExpires() => $_has(1);
  @$pb.TagNumber(2)
  void clearExpires() => $_clearField(2);
}

class Query extends $pb.GeneratedMessage {
  factory Query({
    $core.String? query,
  }) {
    final result = create();
    if (query != null) result.query = query;
    return result;
  }

  Query._();

  factory Query.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Query.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Query',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mam.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'query')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Query clone() => Query()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Query copyWith(void Function(Query) updates) =>
      super.copyWith((message) => updates(message as Query)) as Query;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Query create() => Query._();
  @$core.override
  Query createEmptyInstance() => create();
  static $pb.PbList<Query> createRepeated() => $pb.PbList<Query>();
  @$core.pragma('dart2js:noInline')
  static Query getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Query>(create);
  static Query? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get query => $_getSZ(0);
  @$pb.TagNumber(1)
  set query($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasQuery() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuery() => $_clearField(1);
}

class Empty extends $pb.GeneratedMessage {
  factory Empty() => create();

  Empty._();

  factory Empty.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Empty.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Empty',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mam.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Empty clone() => Empty()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Empty copyWith(void Function(Empty) updates) =>
      super.copyWith((message) => updates(message as Empty)) as Empty;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Empty create() => Empty._();
  @$core.override
  Empty createEmptyInstance() => create();
  static $pb.PbList<Empty> createRepeated() => $pb.PbList<Empty>();
  @$core.pragma('dart2js:noInline')
  static Empty getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Empty>(create);
  static Empty? _defaultInstance;
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
