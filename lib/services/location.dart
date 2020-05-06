import 'package:geolocator/geolocator.dart';

import '../models/models.dart';

/// Service for retrieving user's location
class LocationService {
  /// The user's current latitude and longitude.
  Location _userLocation;

  /// Get the user's location. Cached in memory after initial request.
  Future<Location> getUserLocation() async {
    if (_userLocation == null) {
      Position position = await Geolocator().getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
        locationPermissionLevel: GeolocationPermission.locationWhenInUse,
      );
      if (position == null) {
        return null;
      }
      _userLocation = Location(position.latitude, position.longitude);
    }

    return _userLocation;
  }
}
