import 'dart:convert';

import 'package:clean_architecture_weather/core/error/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:clean_architecture_weather/features/current_weather/data/model/current_weather_model.dart';

abstract class CurrentWeatherRemoteDataSource {
  Future<CurrentWeatherModel> fetchCurrentWeather(String query);
}

const API_KEY = 'ba6132e9e939425d9e9115848211410';

class CurrentWeatherRemoteDataSourceImpl
    implements CurrentWeatherRemoteDataSource {
  final http.Client client;

  CurrentWeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<CurrentWeatherModel> fetchCurrentWeather(String query) =>
      _fetchCurrentWeather(
          "https://api.weatherapi.com/v1/current.json?key=$API_KEY&q=$query");

  Future<CurrentWeatherModel> _fetchCurrentWeather(String url) async {
    final response = await client.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
    });

    if (response.statusCode == 200) {
      return CurrentWeatherModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
