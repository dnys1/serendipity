part of 'places_bloc.dart';

abstract class PlacesState extends Equatable {
  const PlacesState();

  @override
  List<Object> get props => [];
}

class PlacesInitial extends PlacesState {}

class PlacesRequestInProgress extends PlacesState {
  const PlacesRequestInProgress();
}

class PlacesSuccess extends PlacesState {
  final Place place;

  const PlacesSuccess(this.place);

  @override
  List<Object> get props => [place];

  @override
  String toString() {
    return 'PlacesSuccess { place: $place }';
  }
}

class PlacesFailure extends PlacesState {
  final String message;

  const PlacesFailure(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() {
    return 'PlacesFailure { message: $message }';
  }
}