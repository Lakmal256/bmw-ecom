import 'package:get_it/get_it.dart';
import 'utils.dart';

GetIt getIt = GetIt.instance;
setupServiceLocator() async {
  getIt.registerSingleton(PopupController());
  getIt.registerLazySingleton(() => ProgressIndicatorController());
}

T locate<T extends Object>() => GetIt.instance<T>();
