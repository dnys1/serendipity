import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'places_response_status.dart';

part 'places_detail_response.g.dart';

@JsonSerializable(createToJson: false)
class PlacesDetailResponse {
  /// A list of results to be parsed into [Place] objects.
  final Map<String, dynamic> result;

  final PlacesResponseStatus status;

  const PlacesDetailResponse({
    @required this.result,
    @required this.status,
  }): assert(result != null, 'Result cannot be null.');

  factory PlacesDetailResponse.fromJson(Map<String, dynamic> json) => _$PlacesDetailResponseFromJson(json);
}