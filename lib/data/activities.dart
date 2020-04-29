import 'dart:math';

import 'package:meta/meta.dart';

import '../models/models.dart';

/// Mock activities for demo-ing the Serendipity concept.
class MockActivities {
  static List<Activity> activities = const [
    Activity(
      description: 'Hiking',
      cta: 'Go for a hike!',
      searchTerm: 'hiking trails',
      moods: [Mood.Adventure, Mood.Chill],
      finType: [FinType.Free],
    ),
    Activity(
      description: 'Zoo',
      cta: 'Go to the zoo!',
      searchTerm: 'zoo',
      moods: [Mood.Chill],
      finType: [FinType.Paid],
    ),
    Activity(
      description: 'Museum',
      cta: 'Go to a museum!',
      searchTerm: 'museum',
      moods: [Mood.Chill],
      finType: [FinType.Paid],
    ),
    Activity(
      description: 'Movies',
      cta: 'Go see a movie!',
      searchTerm: 'movie theater',
      moods: [Mood.Chill],
      finType: [FinType.Paid],
    ),
    Activity(
      description: 'Park',
      cta: 'Go spend the day in the park!',
      searchTerm: 'park',
      moods: [Mood.Chill],
      finType: [FinType.Free],
    ),
    Activity(
      description: 'Random',
      cta: 'Go drive somewhere new!',
      searchTerm: 'tourist attractions',
      moods: [Mood.Adventure],
      finType: [FinType.Free, FinType.Paid],
    ),
  ];

  /// Selects a random activity given a certain mood and financial type.
  static Activity selectRandomActivity({
    @required Mood mood,
    @required FinType finType,
  }) {
    List<Activity> availableActivities = activities.where((Activity test) {
      return test.finType.contains(finType) && test.moods.contains(mood);
    }).toList();

    return availableActivities
        .elementAt(Random().nextInt(availableActivities.length));
  }
}
