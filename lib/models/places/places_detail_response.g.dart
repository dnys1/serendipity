// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'places_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlacesDetailResponse _$PlacesDetailResponseFromJson(Map<String, dynamic> json) {
  return PlacesDetailResponse(
    result: json['result'] as Map<String, dynamic>,
    status: _$enumDecodeNullable(_$PlacesResponseStatusEnumMap, json['status']),
  );
}

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$PlacesResponseStatusEnumMap = {
  PlacesResponseStatus.OK: 'OK',
  PlacesResponseStatus.ZERO_RESULTS: 'ZERO_RESULTS',
  PlacesResponseStatus.OVER_QUERY_LIMIT: 'OVER_QUERY_LIMIT',
  PlacesResponseStatus.REQUEST_DENIED: 'REQUEST_DENIED',
  PlacesResponseStatus.INVALID_REQUEST: 'INVALID_REQUEST',
  PlacesResponseStatus.UNKNOWN_ERROR: 'UNKNOWN_ERROR',
};
