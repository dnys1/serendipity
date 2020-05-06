import 'package:flutter/material.dart';

import '../../locator.dart';
import '../../models/models.dart';
import '../../screens/feed/feed_screen_model.dart';
import '../../services/places.dart';

/// The view model for [DetailScreen].
class DetailScreenModel extends ChangeNotifier {
  /// The Places service, to be injected.
  PlacesService _placesService;

  /// The [FeedScreenModel] to alert when a post has been updated.
  /// This is required because the feed will not update unless its
  /// listeners are also notified of the change.
  FeedScreenModel _feedScreenModel;

  /// The post being viewed in the detail screen.
  final PostModel _post;
  PostModel get post => _post;

  DetailScreenModel(
    this._post, {
    @required FeedScreenModel feedScreenModel,
    PlacesService placesService,
  })  : assert(feedScreenModel != null, 'Feed screen model must be provided.'),
        _feedScreenModel = feedScreenModel,
        _placesService = placesService ?? locator<PlacesService>();

  /// Whether or not the user is editing the page.
  bool get isEditing => _isEditing;
  bool _isEditing = false;

  void setIsEditing(bool isEditing) {
    _isEditing = isEditing;
    notifyListeners();
  }

  /// Loads all remaining photos for `_post`.
  Future<List<PlacesPhoto>> loadPhotos() async {
    return _placesService.getAllPhotosForPlace(_post.place);
  }

  /// Add another person to the activity.
  void addPersonPresent(int person) {
    _post.peoplePresent.add(person);
    notifyListeners();
    _feedScreenModel.notifyListeners();
  }
}
