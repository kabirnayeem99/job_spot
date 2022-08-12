import 'dart:math';

import 'package:faker_dart/faker_dart.dart';

import '../dto/offer_dto.dart';

class RemoteOfferDataSource {
  final _faker = Faker.instance;

  Future<OfferDto> getOffers() async {
    final List<OfferItemDto> offers = List.empty(growable: true);
    for (int i = 0; i < 4; i++) {
      final offer = OfferItemDto(
        courseId: Random().nextInt(1498).toString(),
        offerMessage: _faker.lorem.sentence(wordCount: 8),
        offerId: Random().nextInt(1498).toString(),
      );
      offers.add(offer);
    }
    final dto = OfferDto(offers: offers);
    return dto;
  }
}
