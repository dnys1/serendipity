import 'package:flutter/material.dart';

import '../../models/models.dart';

/// The view model for [AddScreen].
class AddScreenModel extends ChangeNotifier {
  /// The currently selected mood.
  Mood get selectedMood => _selectedMood;
  Mood _selectedMood = Mood.Adventure;

  /// Sets the selected mood from the dropdown.
  void setSelectedMood(Mood mood) {
    _selectedMood = mood;
    notifyListeners();
  }

  /// The currently selected financial type.
  FinType get selectedFinType => _selectedFinType;
  FinType _selectedFinType = FinType.Free;

  /// Sets the selected fintype from the dropdown.
  void setSelectedFinType(FinType finType) {
    _selectedFinType = finType;
    notifyListeners();
  }

  /// The currently selected place.
  Place get currPlace => _currPlace;
  Place _currPlace;

  /// Sets the place delivered from the BLoC.
  void setCurrPlace(Place place) {
    _currPlace = place;
    notifyListeners();
  }

  /// A list of everyone invited to the activity.
  List<int> get invitedPeople => _invitedPeople;
  List<int> _invitedPeople = [0];

  /// Adds a person to the list of invites.
  void addInvitedPerson(int person) {
    _invitedPeople.add(person);
    notifyListeners();
  }
}