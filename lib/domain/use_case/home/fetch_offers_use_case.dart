import 'package:either_dart/either.dart';
import 'package:get_it/get_it.dart';

import '../../entity/offer.dart';
import '../../repository/offer_repository.dart';

class FetchOffersUseCase {
  static Future<Either<String, List<Offer>>> fetchOffers() {
    final repository = GetIt.I.get<OfferRepository>();
    return repository.getOffers();
  }
}
