import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:serendipity/blocs/places/places_bloc.dart';
import 'package:serendipity/data/avatars.dart';
import 'package:serendipity/models/models.dart';
import 'package:serendipity/widgets/add_avatar_button.dart';
import 'package:serendipity/widgets/widgets.dart';

import 'add_screen_model.dart';

class AddScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddScreenModel>(
      create: (_) => AddScreenModel(),
      child: BlocProvider<PlacesBloc>(
        create: (_) => PlacesBloc(),
        child: _AddScreenView(),
      ),
    );
  }
}

/// The screen to add a new activity to the feed.
class _AddScreenView extends StatefulWidget {
  @override
  _AddScreenViewState createState() => _AddScreenViewState();
}

class _AddScreenViewState extends State<_AddScreenView> {
  AddScreenModel _model;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _model = Provider.of<AddScreenModel>(context);
  }

  Widget _buildMoodDropdown() {
    return DropdownButton(
      value: _model.selectedMood,
      items: Mood.values.map((Mood mood) {
        Icon icon;
        switch (mood) {
          case Mood.Adventure:
            icon = Icon(Icons.directions_walk);
            break;
          case Mood.Chill:
            icon = Icon(Icons.local_library);
            break;
          case Mood.Hungry:
            icon = Icon(Icons.local_dining);
            break;
          case Mood.Any:
            icon = Icon(Icons.language);
            break;
        }
        return DropdownMenuItem<Mood>(
          key: Key(mood.toString()),
          value: mood,
          child: Row(
            children: <Widget>[
              icon,
              SizedBox(width: 5),
              Text(mood.toString().split('.')[1]),
            ],
          ),
        );
      }).toList(),
      onChanged: _model.setSelectedMood,
    );
  }

  Widget _buildFinancialTypeDropdown() {
    return DropdownButton(
      value: _model.selectedFinType,
      items: FinType.values.map((FinType finType) {
        Icon icon;
        switch (finType) {
          case FinType.Free:
            icon = Icon(Icons.money_off);
            break;
          case FinType.Paid:
            icon = Icon(Icons.monetization_on);
            break;
          case FinType.Any:
            icon = Icon(Icons.language);
            break;
        }
        return DropdownMenuItem<FinType>(
          key: Key(finType.toString()),
          value: finType,
          child: Row(
            children: <Widget>[
              icon,
              SizedBox(width: 5),
              Text(finType.toString().split('.')[1]),
            ],
          ),
        );
      }).toList(),
      onChanged: _model.setSelectedFinType,
    );
  }

  Widget _buildMagicButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        BlocBuilder<PlacesBloc, PlacesState>(
          builder: (context, state) {
            if (state is PlacesInitial || state is PlacesRequestInProgress) {
              return RaisedButton(
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(50)),
                onPressed: () => BlocProvider.of<PlacesBloc>(context).add(
                    PlacesRequested(
                        mood: _model.selectedMood,
                        finType: _model.selectedFinType)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5.0, vertical: 20.0),
                  child: state is PlacesInitial
                      ? Image.asset('assets/wand.png')
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: CircularProgressIndicator(),
                        ),
                ),
              );
            } else if (state is PlacesSuccess) {
              // Will activate the "Start Activity!" button on the next frame
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _model.setCurrPlace(state.place);
              });
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: PlaceCard(place: state.place),
              );
            } else if (state is PlacesFailure) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(state.message),
              );
            } else {
              throw StateError('Unknown PlacesBloc state: $state');
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Activity'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text('Select your mood'),
                _buildMoodDropdown(),
              ],
            ),
            Column(
              children: <Widget>[
                Text('Select your price range'),
                _buildFinancialTypeDropdown(),
              ],
            ),
            _buildMagicButton(),
            Column(
              children: <Widget>[
                Text('Invite people'),
                SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AvatarBar(
                        avatarIndices: _model.invitedPeople,
                        radius: kLargeAvatarSize,
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      ),
                      SizedBox(width: 5),
                      AddAvatarButton(
                        onSelect: _model.addInvitedPerson,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            RaisedButton(
              child: Text('Start Activity!'),
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: _model.currPlace == null
                  ? null
                  : () {
                      BlocProvider.of<PlacesBloc>(context).add(PlacesCleared());
                      Navigator.of(context).pop(PostModel(
                        place: _model.currPlace,
                        userOwns: true,
                        peoplePresent: _model.invitedPeople,
                        dateTime: DateTime.now(),
                      ));
                    },
            ),
          ],
        ),
      ),
    );
  }
}
