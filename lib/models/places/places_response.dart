import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'places_response_status.dart';

part 'places_response.g.dart';

/// A response to a Place Search query.
@JsonSerializable(createToJson: false)
class PlacesResponse {
  /// A list of results to be parsed into [Place] objects.
  final List<Map<String, dynamic>> results;

  final PlacesResponseStatus status;

  const PlacesResponse({
    @required this.results,
    @required this.status,
  }): assert(results != null, 'Results cannot be null.');

  factory PlacesResponse.fromJson(Map<String, dynamic> json) => _$PlacesResponseFromJson(json);
}