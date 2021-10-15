import 'package:bloc/bloc.dart';
import 'package:clean_architecture_weather/features/current_weather/domain/entities/current_weather.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'current_weather_state.dart';

class CurrentWeatherCubit extends Cubit<CurrentWeatherState> {
  CurrentWeatherCubit() : super(Empty());
}
