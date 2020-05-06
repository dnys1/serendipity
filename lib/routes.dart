import 'package:flutter/material.dart';

import 'screens/screens.dart';
import 'models/models.dart';

class Routes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => FeedScreen());
      case '/add':
        return MaterialPageRoute<PostModel>(builder: (_) => AddScreen());
      case '/detail':
        PostModel post = settings.arguments as PostModel;
        return MaterialPageRoute(builder: (_) => DetailScreen(post));
      default:
        throw UnimplementedError('Route not defined: ${settings.name}');
    }
  }
}
