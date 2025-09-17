import 'package:fire/core/di/injection.config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() {
  // Register FirebaseAuth as a singleton
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  // Initialize injectable dependencies
  getIt.init();
}