import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:serendipity/api/places.dart';
import 'package:serendipity/api/places_exception.dart';

import '../../models/models.dart';

part 'places_event.dart';
part 'places_state.dart';

class PlacesBloc extends Bloc<PlacesEvent, PlacesState> {
  final PlacesAPI placesAPI;

  PlacesBloc({
    @required this.placesAPI,
  }) : assert(placesAPI != null, 'API reference cannot be null');

  @override
  PlacesState get initialState => PlacesInitial();

  @override
  Stream<PlacesState> mapEventToState(
    PlacesEvent event,
  ) async* {
    if (event is PlacesRequested) {
      yield* _mapPlacesRequestedToState(
        mood: event.mood,
        finType: event.finType,
      );
    } else if (event is PlacesCleared) {
      yield PlacesInitial();
    }
  }

  Stream<PlacesState> _mapPlacesRequestedToState({
    @required Mood mood,
    @required FinType finType,
  }) async* {
    yield PlacesRequestInProgress();
    try {
      List<Place> places =
          await placesAPI.retrievePlacesForMoodAndType(mood: mood, finType: finType);

      Place randomPlace = places.elementAt(Random().nextInt(places.length));

      yield PlacesSuccess(randomPlace);
    } on PlacesException catch (e) {
      yield PlacesFailure(e.message);
    } catch (e) {
      yield PlacesFailure(e.toString());
    }
  }
}
