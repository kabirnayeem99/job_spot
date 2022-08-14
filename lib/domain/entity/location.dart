class Location {
  double? latitude;
  double? longitude;
  String? fullAddress;

  Location(this.latitude, this.longitude, this.fullAddress);

  @override
  String toString() {
    return 'Location{latitude: $latitude, longitude: $longitude, fullAddress: $fullAddress}';
  }
}
