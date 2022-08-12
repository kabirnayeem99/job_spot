import '../../domain/entity/offer.dart';

class OfferDto {
  List<OfferItemDto>? offers;

  OfferDto({this.offers});

  OfferDto.fromJson(Map<String, dynamic> json) {
    if (json['offers'] != null) {
      offers = <OfferItemDto>[];
      json['offers'].forEach((v) {
        offers!.add(OfferItemDto.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (offers != null) {
      data['offers'] = offers!.map((offer) => offer.toJson()).toList();
    }
    return data;
  }

  List<Offer> toOfferList() {
    return offers
            ?.map(
              (itemDto) => Offer(
                offerId: itemDto.offerId ?? "",
                courseId: itemDto.courseId ?? "",
                message: itemDto.offerMessage ?? "",
              ),
            )
            .toList() ??
        List.empty();
  }
}

class OfferItemDto {
  String? offerId;
  String? offerMessage;
  String? courseId;

  OfferItemDto({this.offerId, this.offerMessage, this.courseId});

  OfferItemDto.fromJson(Map<String, dynamic> json) {
    offerId = json['offer_id'];
    offerMessage = json['offer_message'];
    courseId = json['course_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['offer_id'] = offerId;
    data['offer_message'] = offerMessage;
    data['course_id'] = courseId;
    return data;
  }
}
