//
//  Generated code. Do not modify.
//  source: mam/v1/mam.proto
//

import "package:connectrpc/connect.dart" as connect;
import "mam.pb.dart" as mamv1mam;

abstract final class MamService {
  /// Fully-qualified name of the MamService service.
  static const name = 'mam.v1.MamService';

  static const search = connect.Spec(
    '/$name/Search',
    connect.StreamType.unary,
    mamv1mam.Query.new,
    mamv1mam.SearchResults.new,
  );

  static const buyVip = connect.Spec(
    '/$name/BuyVip',
    connect.StreamType.unary,
    mamv1mam.VipRequest.new,
    mamv1mam.VipResponse.new,
  );

  static const getThumbnail = connect.Spec(
    '/$name/GetThumbnail',
    connect.StreamType.unary,
    mamv1mam.GetThumbnailRequest.new,
    mamv1mam.GetThumbnailResponse.new,
  );

  static const getProfile = connect.Spec(
    '/$name/GetProfile',
    connect.StreamType.unary,
    mamv1mam.Empty.new,
    mamv1mam.UserData.new,
  );

  static const buyBonus = connect.Spec(
    '/$name/BuyBonus',
    connect.StreamType.unary,
    mamv1mam.BonusRequest.new,
    mamv1mam.BonusResponse.new,
  );

  static const isMamSetup = connect.Spec(
    '/$name/IsMamSetup',
    connect.StreamType.unary,
    mamv1mam.IsMamSetupRequest.new,
    mamv1mam.IsMamSetupResponse.new,
  );
}
