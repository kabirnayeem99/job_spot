import 'package:either_dart/either.dart';

import '../../../data/repository/offer_repository_impl.dart';
import '../../entity/offer.dart';
import '../../repository/offer_repository.dart';

class FetchOffersUseCase {
  static Future<Either<String, List<Offer>>> fetchOffers() {
    final OfferRepository offerRepository = OfferRepositoryImpl();
    return offerRepository.getOffers();
  }
}
