import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'places_response.g.dart';

enum PlacesResponseStatus {
  OK,
  ZERO_RESULTS,
  OVER_QUERY_LIMIT,
  REQUEST_DENIED,
  INVALID_REQUEST,
  UNKNOWN_ERROR
}

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