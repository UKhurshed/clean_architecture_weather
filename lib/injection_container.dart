import 'package:clean_architecture_weather/core/network/network_status.dart';
import 'package:clean_architecture_weather/features/current_weather/data/datasources/current_weather_local_data_source.dart';
import 'package:clean_architecture_weather/features/current_weather/data/datasources/current_weather_remote_data_source.dart';
import 'package:clean_architecture_weather/features/current_weather/data/repositories/current_weather_repository_impl.dart';
import 'package:clean_architecture_weather/features/current_weather/domain/repositories/current_weather_repository.dart';
import 'package:clean_architecture_weather/features/current_weather/presentation/bloc/current_weather_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/util/input_converter.dart';
import 'features/current_weather/domain/usecases/fetch_current_weather_by_query.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Features - CurrentWeather
  //Bloc
  sl.registerFactory(
      () => CurrentWeatherBloc(fetchCurrent: sl(), inputConverter: sl()));

  //use case
  sl.registerLazySingleton(() => FetchCurrentWeatherByQuery(repository: sl()));

  //Repository
  sl.registerLazySingleton<CurrentWeatherRepository>(() =>
      CurrentWeatherRepositoryImpl(
          localDataSource: sl(), remoteDataSource: sl(), networkStatus: sl()));


  // final SharedPreferences sharedPreferences;
  //Data Source
  sl.registerLazySingleton<CurrentWeatherRemoteDataSource>(
      () => CurrentWeatherRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<CurrentWeatherLocalDataSource>(
      () => CurrentWeatherLocalDataSourceImpl(sharedPreferences: sl()));

  //Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkStatus>(() => NetworkStatusImpl(sl()));

  //! External
  // final sharedPreferences = await SharedPreferences.getInstance();
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
