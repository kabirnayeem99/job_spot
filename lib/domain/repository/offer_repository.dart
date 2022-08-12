import 'package:either_dart/either.dart';

import '../entity/offer.dart';

abstract class OfferRepository{

  Future<Either<String, List<Offer>>> getOffers();
}