import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clean_architecture_weather/core/error/failures.dart';
import 'package:clean_architecture_weather/core/util/input_converter.dart';
import 'package:clean_architecture_weather/features/current_weather/domain/entities/current_weather.dart';
import 'package:clean_architecture_weather/features/current_weather/domain/usecases/fetch_current_weather_by_query.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'current_weather_event.dart';

part 'current_weather_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - Query must be have only characters';

class CurrentWeatherBloc
    extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  final FetchCurrentWeatherByQuery fetchCurrentWeatherByQuery;
  final InputConverter inputConverter;

  CurrentWeatherBloc(
      {required FetchCurrentWeatherByQuery fetchCurrent,
      required this.inputConverter})
      : assert(fetchCurrent != null),
        fetchCurrentWeatherByQuery = fetchCurrent,
        super(Empty()) {
    on<CurrentWeatherEvent>((event, emit) {});
  }

  @override
  Stream<CurrentWeatherState> mapEventToState(CurrentWeatherEvent event) async*{
    if(event is FetchCurrentWeatherForQuery){
      final inputEither = inputConverter.checkInputStr(event.query);
      yield* inputEither.fold((failure) async*{
        yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
      }, (string) async*{
        yield Loading();
        final failureOrWeather = await fetchCurrentWeatherByQuery(Params(query: string));
        yield* _eitherLoadedOrErrorState(failureOrWeather);
      });
    }
  }

  Stream<CurrentWeatherState> _eitherLoadedOrErrorState(
        Either<Failure, CurrentWeather> failureOrTrivia,
      ) async* {
    yield failureOrTrivia.fold(
          (failure) => Error(message: _mapFailureToMessage(failure)),
          (string) => Loaded(current: string),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
