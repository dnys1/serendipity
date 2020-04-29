part of 'places_bloc.dart';

abstract class PlacesEvent extends Equatable {
  const PlacesEvent();

  @override
  List<Object> get props => [];
}

class PlacesRequested extends PlacesEvent {
  final Mood mood;
  final FinType finType;

  const PlacesRequested({
    @required this.mood,
    @required this.finType,
  }): assert(mood != null, 'Mood cannot be null.'),
      assert(finType != null, 'FinType cannot be null.');

  @override
  List<Object> get props => [mood, finType];

  @override
  String toString() {
    return 'PlacesRequested { mood: $mood, finType: $finType }';
  }
}