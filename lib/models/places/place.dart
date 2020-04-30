import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

import 'places_photo.dart';

part 'place.g.dart';

/// Identifies a single place for a specific [Activity].
@JsonSerializable(createToJson: false)
class Place extends Equatable {
  /// The unique identifier for this place. Used for creating `googleMapsUrl`.
  @JsonKey(name: 'place_id')
  final String id;

  /// The name of the place (business/location).
  final String name;

  /// The URL of a recommended icon to display to the user.
  final String icon;

  /// A list of photo references for this place.
  @JsonKey(name: 'photos', fromJson: photoReferencesFromJson)
  final List<PlacesPhoto> photoReferences;

  /// The user rating on Google Maps.
  final double rating;

  /// A direct link to Google Maps. The `query` parameter is required, however it is only used
  /// if `query_place_id` returns no results. Since this is the returned value from a Places API
  /// call, it should always be valid. Nonetheless, `query` is specified as the place name because
  /// it shows in the search box on Google Maps.
  String get googleMapsUrl =>
      'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(name)}&query_place_id=$id';

  Place({
    @required this.id,
    @required this.name,
    this.icon,
    this.photoReferences = const [],
    this.rating,
  })  : assert(id != null, 'ID cannot be null.'),
        assert(name != null, 'Name cannot be null.');

  @override
  List<Object> get props => [id, name, icon, photoReferences];

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);

  static List<PlacesPhoto> photoReferencesFromJson(List<dynamic> photos) {
    if (photos == null) {
      return [];
    }
    
    List<PlacesPhoto> results = [];

    for (var photo in photos) {
      photo = photo as Map<String, dynamic>;
      results.add(PlacesPhoto(
        id: photo['photo_reference'],
        maxHeight: photo['height'],
        maxWidth: photo['width'],
      ));
    }

    return results;
  }

  @override
  String toString() {
    return '''\n
    Place {
      id: $id,
      name: $name,
      icon: $icon,
      photoReferences: $photoReferences,
      rating: $rating,
    }
    ''';
  }
}
