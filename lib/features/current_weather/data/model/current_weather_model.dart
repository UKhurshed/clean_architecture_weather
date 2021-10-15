import 'package:clean_architecture_weather/features/current_weather/domain/entities/current_weather.dart';

class CurrentWeatherModel extends CurrentWeather {
  const CurrentWeatherModel({
    required Location location,
    required Current current,
  }) : super(location: location, current: current);

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) =>
      CurrentWeatherModel(
        location: Location.fromJson(json["location"]),
        current: Current.fromJson(json["current"]),
      );

  Map<String, dynamic> toJson() {
    return {"location": location, "current": current};
  }
}
