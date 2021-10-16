import 'package:clean_architecture_weather/features/current_weather/domain/entities/current_weather.dart';
import 'package:flutter/material.dart';

class CurrentWeatherDisplay extends StatelessWidget {
  final CurrentWeather currentWeather;

  const CurrentWeatherDisplay({
    required this.currentWeather,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        children: <Widget>[
          Text(
            currentWeather.current.tempC.toString(),
            style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Text(
                  "${currentWeather.location.country} ${currentWeather.location.region} ${currentWeather.location.name}",
                  style: const TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
