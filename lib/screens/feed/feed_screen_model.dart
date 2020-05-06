import 'package:flutter/material.dart';

import '../../locator.dart';
import '../../models/models.dart';
import '../../services/places.dart';

class FeedScreenModel extends ChangeNotifier {
  PlacesService _placesService;

  FeedScreenModel({
    PlacesService placesService,
  }) : _placesService = placesService ?? locator<PlacesService>();

  /// The list of all feed items.
  List<PostModel> _feed = [];
  List<PostModel> get feed => _feed;

  /// Generate a clickable post for a bunch of random places.
  Future<bool> loadFeed() async {
    while (_feed.length < 50) {
      _feed.addAll((await _placesService.retrievePlacesForMoodAndType(
              mood: Mood.Any, finType: FinType.Any))
          .where((Place place) => place.photoReferences.isNotEmpty)
          .map((Place place) => PostModel(place: place)));
      _feed.shuffle();
    }

    return true;
  }

  /// The pending post of the user.
  PostModel _pendingPost;
  PostModel get pendingPost => _pendingPost;

  /// Sets the currently pending post.
  void setPendingPost(PostModel post) {
    _pendingPost = post;
    notifyListeners();
  }

  /// Marks the pending post as complete.
  void completePendingPost() {
    if (_pendingPost != null) {
      _feed.insert(0, _pendingPost);
      _pendingPost = null;
      notifyListeners();
    }
  }
}
