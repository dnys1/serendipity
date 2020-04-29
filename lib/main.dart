import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serendipity/api/places.dart';
import 'package:serendipity/blocs/bloc_delegate.dart';
import 'package:serendipity/screens/feed/add_screen.dart';
import 'package:serendipity/screens/screens.dart';

import 'blocs/places/places_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(SerendipityApp());
}

class SerendipityApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PlacesBloc>(
      create: (_) => PlacesBloc(placesAPI: PlacesAPI()),
      child: MaterialApp(
        title: 'Serendipity',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          '/add': (_) => AddScreen(),
        },
        home: FeedScreen(),
      ),
    );
  }
}
