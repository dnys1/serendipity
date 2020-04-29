class PlacesException implements Exception {
  final String message;

  const PlacesException(this.message);

  @override
  String toString() {
    return 'PlacesException { message: $message }';
  }
}