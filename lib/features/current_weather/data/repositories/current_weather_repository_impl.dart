import 'package:clean_architecture_weather/core/error/exceptions.dart';
import 'package:clean_architecture_weather/core/error/failures.dart';
import 'package:clean_architecture_weather/core/network/network_status.dart';
import 'package:clean_architecture_weather/features/current_weather/data/datasources/current_weather_local_data_source.dart';
import 'package:clean_architecture_weather/features/current_weather/data/datasources/current_weather_remote_data_source.dart';
import 'package:clean_architecture_weather/features/current_weather/domain/entities/current_weather.dart';
import 'package:clean_architecture_weather/features/current_weather/domain/repositories/current_weather_repository.dart';
import 'package:dartz/dartz.dart';

typedef Future<CurrentWeather> _CurrentWeather();

class CurrentWeatherRepositoryImpl implements CurrentWeatherRepository {
  final CurrentWeatherLocalDataSource localDataSource;
  final CurrentWeatherRemoteDataSource remoteDataSource;
  final NetworkStatus networkStatus;

  CurrentWeatherRepositoryImpl({required this.localDataSource,
    required this.remoteDataSource,
    required this.networkStatus});

  @override
  Future<Either<Failure, CurrentWeather>> fetchCurrentWeatherByQuery(
      String query) async {
    if(await networkStatus.isConnected){
      try{
        final remoteWeather = await remoteDataSource.fetchCurrentWeather(query);
        localDataSource.cacheCurrentWeather(remoteWeather);
        return Right(remoteWeather);
      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      final localWeather = await localDataSource.getCurrentWeather();
      return Right(localWeather);
    }
  }

  // Future<Either<Failure, CurrentWeather>> _fetchCurrent(
  //     _CurrentWeather currentWeather) async {
  //   if (await networkStatus.isConnected) {
  //     try {
  //       final remoteWeather = await currentWeather();
  //       localDataSource.cacheCurrentWeather(remoteWeather);
  //       return Right(remoteWeather);
  //     } on ServerException {
  //       return Left(ServerFailure());
  //     }
  //   } else {
  //     try {
  //       final localWeather = await localDataSource.getCurrentWeather();
  //       return Right(localWeather);
  //     } on CacheException {
  //       return Left(CacheFailure());
  //     }
  //   }
  // }
}
