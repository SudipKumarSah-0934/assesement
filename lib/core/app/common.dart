// Common Dependencies

import 'package:genius_assesment/core/networkchecker/network_info.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'di.dart';

void registerCommonDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();


  sl.registerLazySingleton(() => sharedPreferences);
  
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());

  // Register NetworkInfo
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
}
