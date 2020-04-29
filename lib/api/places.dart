import 'package:meta/meta.dart';

import '../models/models.dart';

/// The repository for interacting with the Google Places API, which is used to 
/// select random destinations based on a user's choice of mood and financial type.
class PlacesAPI {
  /// API Key for querying the Places API
  static const String API_KEY = 'AIzaSyDqSyWnhK-2u4XbN9zYOYaJDlfO1DUolKs';

  /// Default search radius, in meters (max. 50,000)
  static const int DEFAULT_RADIUS = 5000;

  /// The base url for a Place API nearby search request
  static const String searchUrl = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?';

  /// The base url for a Places API photo request
  static const String photoRequestUrl = 'https://maps.googleapis.com/maps/api/place/photo?';

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

    return searchUrl + 'keyword=$keyword&location=$latlong&radius=$DEFAULT_RADIUS&key=$API_KEY';
  }

  /// Creates a Places API photo request URL starting with `photoRequestUrl`.
  static String createPhotoRequestUrl({
    @required String photoReference,
    int height,
    int width,
  }) {
    assert(height != null || width != null, 'Either height or width must be specified.');

    String requestUrl = photoRequestUrl + 'photoreference=$photoReference&key=$API_KEY';

    if (height != null) {
      requestUrl += '&maxheight=$height';
    } else {
      requestUrl += '&maxwidth=$width';
    }

    return requestUrl;
  }
}