import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:serendipity/api/places.dart';

class PlacesPhoto extends Equatable {
  /// The `photo_reference` property of the Places API body.
  final String id;

  /// The photo's maximum height, in pixels.
  final int maxHeight;

  /// The photo's maximum width, in pixels.
  final int maxWidth;

  const PlacesPhoto({
    @required this.id,
    @required this.maxHeight,
    @required this.maxWidth,
  });

  @override
  List<Object> get props => [id, maxHeight, maxWidth];

  /// Request a URL for this photo given a certain height, in pixels.
  String getRequestUrlForHeight(int height) => PlacesAPI.createPhotoRequestUrl(
        photoReference: id,
        height: min(maxHeight, height),
      );

  /// Request a URL for this photo given a certain width, in pixels.
  String getRequestUrlForWidth(int width) => PlacesAPI.createPhotoRequestUrl(
        photoReference: id,
        width: min(maxWidth, width),
      );

  @override
  String toString() {
    return '''\n
    PlacesPhoto {
      id: $id,
      maxHeight: $maxHeight,
      maxWidth: $maxWidth,
    }
    ''';
  }
}
