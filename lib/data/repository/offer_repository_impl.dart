import 'package:either_dart/either.dart';

import '../../common/utility/utility.dart';
import '../../domain/entity/offer.dart';
import '../../domain/repository/offer_repository.dart';
import '../data_source/remote_offer_data_source.dart';

class OfferRepositoryImpl extends OfferRepository {
  final _offerRemoteDataSource = RemoteOfferDataSource();

  @override
  Future<Either<String, List<Offer>>> getOffers() async {
    try {
      final dto = await _offerRemoteDataSource.getOffers();
      final offers = dto.toOfferList();
      return Right(offers);
    } on Exception catch (e) {
      logger.e(e);
      return Left(e.toString());
    }
  }
}
