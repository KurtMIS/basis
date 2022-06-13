import 'package:get_it/get_it.dart';

import '../modules/logics/input.dart';
import '../modules/logics/login.dart';
import '../modules/logics/main.dart';
import '../modules/logics/view.dart';

final locator = GetIt.I;

void locatorSetup() {
  locator.registerLazySingleton<Login>(() => Login());
  locator.registerSingleton<Main>(Main());
  locator.registerLazySingleton<View>(() => View());
  locator.registerLazySingleton<Input>(() => Input());
}
