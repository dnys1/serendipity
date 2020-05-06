import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serendipity/services/places.dart';
import 'package:serendipity/blocs/bloc_delegate.dart';
import 'package:serendipity/screens/screens.dart';

import 'blocs/places/places_bloc.dart';
import 'locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  setupLocator();

  runApp(SerendipityApp());
}

class SerendipityApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PlacesBloc>(
      create: (_) => PlacesBloc(),
      child: MaterialApp(
        title: 'Serendipity',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: FeedScreen(),
      ),
    );
  }
}
