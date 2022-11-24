import 'package:get_it/get_it.dart';
import 'package:mesh/feature/auth/data/auth_api_repository.dart';

void setupDependencies() {
  GetIt.instance.registerSingleton<AuthApiRepository>(AuthApiRepository());
}
