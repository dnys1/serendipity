import 'package:meta/meta.dart';

import 'models.dart';

class Activity {
  /// A one-word activity description.
  final String description;

  /// The user-facing call to action for this activity, i.e. 'Go for a hike!'.
  final String cta;

  /// The search term used to query Google for nearby activities of this type.
  final String searchTerm;

  /// A list of moods this activity satisfies.
  final List<Mood> moods;

  /// A list of financial types (i.e. Free/Paid) this activity satisfies.
  final List<FinType> finType;

  const Activity({
    @required this.description,
    @required this.cta,
    @required this.searchTerm,
    @required this.moods,
    @required this.finType,
  });
}