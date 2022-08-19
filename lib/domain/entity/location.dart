import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final double? latitude;
  final double? longitude;
  final String? fullAddress;

  const Location(this.latitude, this.longitude, this.fullAddress);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [latitude, longitude];
}
