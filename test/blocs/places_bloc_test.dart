import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:serendipity/services/places.dart';
import 'package:serendipity/blocs/places/places_bloc.dart';
import 'package:serendipity/models/models.dart';

class MockAPI extends Mock implements PlacesService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MockAPI mockAPI;
  Place testPlace = Place(
    id: 'mock',
    name: 'Mock Place',
  );

  setUp(() {
    mockAPI = MockAPI();
  });

  group('PlacesRequested', () {
    blocTest(
      'PlacesSuccess',
      build: () async {
        when(mockAPI.retrievePlacesForMoodAndType(
                mood: anyNamed('mood'), finType: anyNamed('finType')))
            .thenAnswer((_) async => [testPlace]);
        return PlacesBloc(placesAPI: mockAPI);
      },
      act: (bloc) =>
          bloc.add(PlacesRequested(mood: Mood.Any, finType: FinType.Any)),
      expect: [
        PlacesRequestInProgress(),
        PlacesSuccess(testPlace),
      ],
    );

    blocTest(
      'PlacesFailure',
      build: () async {
        when(mockAPI.retrievePlacesForMoodAndType(
                mood: anyNamed('mood'), finType: anyNamed('finType')))
            .thenThrow(PlacesException('Error'));
        return PlacesBloc(placesAPI: mockAPI);
      },
      act: (bloc) =>
          bloc.add(PlacesRequested(mood: Mood.Any, finType: FinType.Any)),
      expect: [
        PlacesRequestInProgress(),
        PlacesFailure('Error'),
      ],
    );
  });

  group('PlacesCleared', () {
    blocTest(
      'PlacesSuccess to start',
      build: () async {
        when(mockAPI.retrievePlacesForMoodAndType(
                mood: anyNamed('mood'), finType: anyNamed('finType')))
            .thenAnswer((_) async => [testPlace]);
        return PlacesBloc(placesAPI: mockAPI);
      },
      act: (bloc) async {
        bloc.add(PlacesRequested(mood: Mood.Any, finType: FinType.Any));
        bloc.add(PlacesCleared());
      },
      expect: [
        PlacesRequestInProgress(),
        PlacesSuccess(testPlace),
        PlacesInitial(),
      ],
    );

    blocTest(
      'PlacesFailure to start',
      build: () async {
        when(mockAPI.retrievePlacesForMoodAndType(
                mood: anyNamed('mood'), finType: anyNamed('finType')))
            .thenThrow(PlacesException('Error'));
        return PlacesBloc(placesAPI: mockAPI);
      },
      act: (bloc) async {
        bloc.add(PlacesRequested(mood: Mood.Any, finType: FinType.Any));
        bloc.add(PlacesCleared());
      },
      expect: [
        PlacesRequestInProgress(),
        PlacesFailure('Error'),
        PlacesInitial(),
      ],
    );
  });
}
