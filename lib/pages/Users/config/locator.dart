import 'package:get_it/get_it.dart';
import 'package:oya_porter/pages/Users/service/navigationService.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
   locator.registerLazySingleton(() => NavigationService());
}