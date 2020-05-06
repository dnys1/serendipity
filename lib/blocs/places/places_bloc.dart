import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../locator.dart';
import '../../services/places.dart';
import '../../models/models.dart';

part 'places_event.dart';
part 'places_state.dart';

/// Ferries requests to [PlacesService] and returns results from API calls.
class PlacesBloc extends Bloc<PlacesEvent, PlacesState> {
  final PlacesService _placesService;

  PlacesBloc({
    PlacesService placesService,
  }) : _placesService = placesService ?? locator<PlacesService>();

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
      List<Place> places = await _placesService.retrievePlacesForMoodAndType(
          mood: mood, finType: finType);

      Place randomPlace = places.elementAt(Random().nextInt(places.length));

      yield PlacesSuccess(randomPlace);
    } on PlacesException catch (e) {
      yield PlacesFailure(e.message);
    } catch (e) {
      yield PlacesFailure(e.toString());
    }
  }
}
