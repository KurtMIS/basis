import 'package:get_it/get_it.dart';

import '../modules/logics/input.dart';
import '../modules/logics/login.dart';
import '../modules/logics/main.dart';
import '../repositories/input_repo.dart';

final locator = GetIt.I;

void locatorSetup() {
  locator.registerLazySingleton<Login>(() => Login());
  locator.registerSingleton<Main>(Main());
  locator.registerLazySingleton<Input>(() => Input());
  locator.registerLazySingleton<InputRepo>(() => InputRepo());
}
