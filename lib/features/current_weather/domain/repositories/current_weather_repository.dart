import 'package:clean_architecture_weather/core/error/failures.dart';
import 'package:clean_architecture_weather/features/current_weather/domain/entities/current_weather.dart';
import 'package:dartz/dartz.dart';

abstract class CurrentWeatherRepository {
  Future<Either<Failure, CurrentWeather>> fetchCurrentWeatherByQuery(
      String query);
}
