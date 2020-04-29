// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Place _$PlaceFromJson(Map<String, dynamic> json) {
  return Place(
    id: json['place_id'] as String,
    name: json['name'] as String,
    icon: json['icon'] as String,
    photoReferences: Place.photoReferencesFromJson(json['photos'] as List),
    rating: (json['rating'] as num)?.toDouble(),
  );
}
