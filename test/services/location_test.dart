import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:serendipity/models/models.dart';
import 'package:serendipity/services/location.dart';
import 'package:serendipity/services/places.dart';

class MockLocationService extends Mock implements LocationService {}

void main() {
  final locator = GetIt.instance;

  LocationService _locationService;
  PlacesService _placesService;

  Location mockLocation = Location(33.44958, -111.98504);

  setUp(() {
    _locationService = MockLocationService();
    locator.registerSingleton(_locationService);
    _placesService = PlacesService();
  });

  tearDown(() {
    locator.reset();
  });

  group('Location retrieval', () {
    test('Location retrieval OK', () async {
      when(_locationService.getUserLocation())
          .thenAnswer((_) async => mockLocation);

      var results = await _placesService.retrievePlacesForMoodAndType(
          mood: Mood.Any, finType: FinType.Any);

      expect(results, isInstanceOf<List<Place>>());
      expect(results, isNotEmpty);
    });

    test('Location retrieval FAIL', () async {
      when(_locationService.getUserLocation()).thenAnswer((_) async => null);

      expectLater(_placesService.retrievePlacesForMoodAndType(
              mood: Mood.Any, finType: FinType.Any),
          throwsA(isInstanceOf<PlacesException>()));
    });
  });
}
