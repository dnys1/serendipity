import 'package:flutter/material.dart';

import '../../models/models.dart';

class AddScreenModel extends ChangeNotifier {
  /// The currently selected mood.
  Mood get selectedMood => _selectedMood;
  Mood _selectedMood = Mood.Adventure;

  void setSelectedMood(Mood mood) {
    _selectedMood = mood;
    notifyListeners();
  }

  /// The currently selected financial type.
  FinType get selectedFinType => _selectedFinType;
  FinType _selectedFinType = FinType.Free;

  void setSelectedFinType(FinType finType) {
    _selectedFinType = finType;
    notifyListeners();
  }

  /// The currently selected place.
  Place get currPlace => _currPlace;
  Place _currPlace;

  void setCurrPlace(Place place) {
    _currPlace = place;
    notifyListeners();
  }

  /// A list of everyone invited to the activity.
  List<int> get invitedPeople => _invitedPeople;
  List<int> _invitedPeople = [0];

  void addInvitedPerson(int person) {
    _invitedPeople.add(person);
    notifyListeners();
  }
}