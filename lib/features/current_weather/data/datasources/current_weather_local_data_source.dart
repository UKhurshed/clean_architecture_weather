import 'dart:convert';
import 'package:clean_architecture_weather/core/error/exceptions.dart';
import 'package:clean_architecture_weather/features/current_weather/data/model/current_weather_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CurrentWeatherLocalDataSource {
  Future<CurrentWeatherModel> getCurrentWeather();

  Future<void> cacheCurrentWeather(CurrentWeatherModel currentWeatherModel);
}

const CACHED_CURRENT_WEATHER = 'CACHED_CURRENT_WEATHER';

class CurrentWeatherLocalDataSourceImpl
    implements CurrentWeatherLocalDataSource {
  final SharedPreferences sharedPreferences;

  const CurrentWeatherLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheCurrentWeather(CurrentWeatherModel currentWeatherModel) {
    return sharedPreferences.setString(
        CACHED_CURRENT_WEATHER, json.encode(currentWeatherModel.toJson()));
  }

  @override
  Future<CurrentWeatherModel> getCurrentWeather() {
    final jsonString = sharedPreferences.getString(CACHED_CURRENT_WEATHER);
    if (jsonString != null) {
      return Future.value(
          CurrentWeatherModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}
