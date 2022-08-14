class Offer {
  final String offerId;
  final String courseId;
  final String message;

  Offer({required this.offerId, required this.courseId, required this.message});

  @override
  String toString() {
    return 'Offer{offerId: $offerId, courseId: $courseId, message: $message}';
  }
}
