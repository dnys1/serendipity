/// A location represented by a latitude/longitude pair.
class Location {
  final double lat;
  final double long;

  const Location(this.lat, this.long)
      : assert(lat >= -90 && lat <= 90, 'Latitude is invalid.'),
        assert(long >= -180 && long <= 180, 'Longitude is invalid');
}
