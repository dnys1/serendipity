import 'dart:math';

import 'package:flutter/material.dart';

import '../data/avatars.dart';
import 'models.dart';

/// Represents a [Post] in the Feed.
class PostModel {
  /// Whether or not the user owns this post.
  final bool userOwns;

  /// The place represented by this post.
  final Place place;

  /// The date and time this post was made.
  final DateTime dateTime;

  /// A list of people present.
  /// The avatar index for this demo.
  final List<int> peoplePresent;

  /// The user's rating, if they own the post
  final int userRating;

  PostModel({
    @required this.place,
    this.userOwns = false,
    DateTime dateTime,
    List<int> peoplePresent,
    this.userRating,
  })  : assert(place != null, 'Place cannot be null.'),
        this.dateTime = dateTime ?? _randomDate,
        this.peoplePresent = peoplePresent ?? _randomPeoplePresent;

  /// Picks a random date from 2019
  static DateTime get _randomDate =>
      DateTime(2019, Random().nextInt(12) + 1, Random().nextInt(30) + 1);

  /// Picks at most 5 random avatars
  static List<int> get _randomPeoplePresent => List.generate(
      Random().nextInt(4) + 1,
      (index) => Random().nextInt(Avatars.avatars.length));
}
