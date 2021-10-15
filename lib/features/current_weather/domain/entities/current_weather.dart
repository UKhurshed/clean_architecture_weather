import 'package:equatable/equatable.dart';

class CurrentWeather extends Equatable {
  final Location location;
  final Current current;

  const CurrentWeather({required this.location, required this.current});

  @override
  List<Object?> get props => [location, current];
}

class Location extends Equatable {
  final String name;
  final String region;
  final String country;

  const Location(
      {required this.name, required this.region, required this.country});

  @override
  List<Object?> get props => [name, region, country];

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"],
        region: json["region"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "region": region,
        "country": country,
      };
}

class Current extends Equatable {
  final int tempC;
  final double tempF;
  final Condition condition;
  final double windMph;
  final double windKph;
  final int cloud;

  const Current(
      {required this.tempC,
      required this.tempF,
      required this.condition,
      required this.windMph,
      required this.windKph,
      required this.cloud});

  @override
  List<Object?> get props => [tempC, tempF, condition, windMph, windKph, cloud];

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        tempC: json["temp_c"],
        tempF: json["temp_f"].toDouble(),
        condition: Condition.fromJson(json["condition"]),
        windMph: json["wind_mph"].toDouble(),
        windKph: json["wind_kph"].toDouble(),
        cloud: json["cloud"],
      );

  Map<String, dynamic> toJson() => {
        "temp_c": tempC,
        "temp_f": tempF,
        "condition": condition.toJson(),
        "wind_mph": windMph,
        "wind_kph": windKph,
        "cloud": cloud,
      };
}

class Condition extends Equatable {
  final String text;
  final String icon;
  final int code;

  const Condition({required this.text, required this.icon, required this.code});

  @override
  List<Object?> get props => [text, icon, code];

  factory Condition.fromJson(Map<String, dynamic> json) => Condition(
        text: json["text"],
        icon: json["icon"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "icon": icon,
        "code": code,
      };
}
