part of 'current_weather_cubit.dart';

@immutable
abstract class CurrentWeatherState extends Equatable{

  @override
  List<Object> get props => [];
}

class Empty extends CurrentWeatherState {}

class Loading extends CurrentWeatherState {}

class Loaded extends CurrentWeatherState {
  final CurrentWeather current;

  Loaded({required this.current});

  @override
  List<Object> get props => [current];
}

class Error extends CurrentWeatherState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}
