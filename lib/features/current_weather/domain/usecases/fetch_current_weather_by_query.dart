
import 'package:clean_architecture_weather/core/error/failures.dart';
import 'package:clean_architecture_weather/core/usecase/usecase.dart';
import 'package:clean_architecture_weather/features/current_weather/domain/entities/current_weather.dart';
import 'package:clean_architecture_weather/features/current_weather/domain/repositories/current_weather_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class FetchCurrentWeatherByQuery implements UseCase<CurrentWeather, Params>{
  final CurrentWeatherRepository repository;

  const FetchCurrentWeatherByQuery({required this.repository});

  @override
  Future<Either<Failure, CurrentWeather>> call(params) async{
    throw await repository.fetchCurrentWeatherByQuery(params.query);
  }
}

class Params extends Equatable{

  final String query;
  const Params({required this.query});

  @override
  List<Object> get props => [query];
}