import 'package:get_it/get_it.dart';
import 'package:map_exam/repositories/auth_repo.dart';
import 'package:map_exam/repositories/note_repo.dart';


/*
* config of the dependency injection for the this app
* */

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory(() => FirebaseAuthenticationRepository());
  locator.registerFactory(() => FirebaseNotesRepository());
}