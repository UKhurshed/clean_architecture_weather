part of 'current_weather_bloc.dart';

@immutable
abstract class CurrentWeatherEvent extends Equatable {

  @override
  List<Object> get props => [];
}

class FetchCurrentWeatherForQuery extends CurrentWeatherEvent {
  final String query;

  FetchCurrentWeatherForQuery(this.query);

  @override
  List<Object> get props => [query];
}
