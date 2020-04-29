import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:serendipity/api/places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:serendipity/data/activities.dart';
import 'package:http/http.dart' as http;

import '../../models/models.dart';

part 'places_event.dart';
part 'places_state.dart';

class PlacesBloc extends Bloc<PlacesEvent, PlacesState> {
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
    }
  }

  Stream<PlacesState> _mapPlacesRequestedToState({
    @required Mood mood,
    @required FinType finType,
  }) async* {
    yield PlacesRequestInProgress();
    try {
      // Get a random activity to use
      Activity randomActivity = MockActivities.selectRandomActivity(
        mood: mood,
        finType: finType,
      );

      // Get the user's location
      Position position = await Geolocator().getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
        locationPermissionLevel: GeolocationPermission.locationWhenInUse,
      );

      print('lat: ${position.latitude}, long: ${position.longitude}');

      // Generate and send the Places API request
      String requestUrl = PlacesAPI.createRequestUrl(
        keyword: randomActivity.searchTerm,
        location: Location(position.latitude, position.longitude),
      );

      final http.Response resp = await http.get(requestUrl);

      if (resp.statusCode != 200) {
        yield PlacesFailure(resp.body);
        return;
      }

      // Parse the results of the query to a list of [Place] entities.
      final PlacesResponse placesResponse =
          PlacesResponse.fromJson(json.decode(resp.body));

      if (placesResponse.status != PlacesResponseStatus.OK) {
        yield PlacesFailure(placesResponse.status.toString().split('.')[1]);
        return;
      }

      final List<Place> places =
          placesResponse.results.map((json) => Place.fromJson(json)).toList();

      yield PlacesSuccess(places.elementAt(Random().nextInt(places.length)));
    } catch (e) {
      yield PlacesFailure(e.toString());
    }
  }
}
