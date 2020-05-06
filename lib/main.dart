import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'locator.dart';
import 'routes.dart';
import 'blocs/bloc_delegate.dart';
import 'screens/feed/feed_screen_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  setupLocator();

  runApp(SerendipityApp());
}

class SerendipityApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FeedScreenModel>(
      create: (_) => FeedScreenModel(),
      child: MaterialApp(
        title: 'Serendipity',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        onGenerateRoute: Routes.onGenerateRoute,
      ),
    );
  }
}
