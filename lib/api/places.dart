import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:serendipity/api/places_exception.dart';
import 'package:serendipity/data/activities.dart';

import '../models/models.dart';

/// The repository for interacting with the Google Places API, which is used to
/// select random destinations based on a user's choice of mood and financial type.
class PlacesAPI {
  static final PlacesAPI _singleton = PlacesAPI._();

  factory PlacesAPI() => _singleton;

  PlacesAPI._();

  /// API Key for querying the Places API
  static const String API_KEY = 'AIzaSyDqSyWnhK-2u4XbN9zYOYaJDlfO1DUolKs';

  /// Default search radius, in meters (max. 50,000)
  static const int DEFAULT_RADIUS = 5000;

  /// The base url for a Places API nearby search request
  static const String searchUrl =
      'https://maps.googleapis.com/maps/api/place/nearbysearch/json?';

  /// The base url for a Places API details request
  static const String detailsUrl =
      'https://maps.googleapis.com/maps/api/place/details/json?';

  /// The base url for a Places API photo request
  static const String photoRequestUrl =
      'https://maps.googleapis.com/maps/api/place/photo?';

  /// The user's current latitude and longitude.
  Location _userLocation;

  /// Creates the Places API search request URL starting with `searchUrl`.
  static String createRequestUrl({
    @required String keyword,
    @required Location location,
  }) {
    assert(keyword != null, 'Keyword cannot be null.');
    assert(location != null, 'Location cannot be null.');

    // All parameters must be encoded properly
    keyword = Uri.encodeComponent(keyword);
    String latlong = '${location.lat},${location.long}';

    return searchUrl +
        'keyword=$keyword&location=$latlong&radius=$DEFAULT_RADIUS&key=$API_KEY';
  }

  /// Creates a Places API details request, used for getting more images.
  static String createDetailRequestUrl(String placeId) {
    return detailsUrl + 'place_id=$placeId&fields=photo&key=$API_KEY';
  }

  /// Creates a Places API photo request URL starting with `photoRequestUrl`.
  static String createPhotoRequestUrl({
    @required String photoReference,
    int height,
    int width,
  }) {
    assert(height != null || width != null,
        'Either height or width must be specified.');

    String requestUrl =
        photoRequestUrl + 'photoreference=$photoReference&key=$API_KEY';

    if (height != null) {
      requestUrl += '&maxheight=$height';
    } else {
      requestUrl += '&maxwidth=$width';
    }

    return requestUrl;
  }

  Future<List<PlacesPhoto>> getAllPhotosForPlace(Place place) async {
    String requestUrl = createDetailRequestUrl(place.id);

    final http.Response resp = await http.get(requestUrl);

    if (resp.statusCode != 200) {
      throw PlacesException(resp.body);
    }

    // Parse the results of the query to a list of [Place] entities.
    final PlacesDetailResponse placesResponse =
        PlacesDetailResponse.fromJson(json.decode(resp.body));

    if (placesResponse.status != PlacesResponseStatus.OK) {
      throw PlacesException(placesResponse.status.toString().split('.')[1]);
    }

    return Place.photoReferencesFromJson(placesResponse.result['photos']);
  }

  Future<List<Place>> getRandomPlace({
    @required Mood mood,
    @required FinType finType,
  }) async {
    // Get a random activity to use
    Activity randomActivity = MockActivities.selectRandomActivity(
      mood: mood,
      finType: finType,
    );

    // Get the user's location (only once)
    if (_userLocation == null) {
      Position position = await Geolocator().getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
        locationPermissionLevel: GeolocationPermission.locationWhenInUse,
      );
      _userLocation = Location(position.latitude, position.longitude);
    }

    // Generate and send the Places API request
    String requestUrl = PlacesAPI.createRequestUrl(
      keyword: randomActivity.searchTerm,
      location: _userLocation,
    );

    final http.Response resp = await http.get(requestUrl);

    if (resp.statusCode != 200) {
      throw PlacesException(resp.body);
    }

    // Parse the results of the query to a list of [Place] entities.
    final PlacesResponse placesResponse =
        PlacesResponse.fromJson(json.decode(resp.body));

    if (placesResponse.status != PlacesResponseStatus.OK) {
      throw PlacesException(placesResponse.status.toString().split('.')[1]);
    }

    return placesResponse.results
        .map((json) => Place.fromJson(json))
        .where((Place place) => place.photoReferences.isNotEmpty)
        .toList();
  }
}
