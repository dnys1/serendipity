import 'package:get_it/get_it.dart';

import 'services/places.dart';
import 'services/location.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton(PlacesService());
  locator.registerSingleton(LocationService());
}