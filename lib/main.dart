import 'package:flutter/material.dart';
import 'features/current_weather/presentation/page/current_weather_page.dart';
import 'injection_container.dart' as di;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Current Weather',
      theme: ThemeData(
        primaryColor: Colors.green.shade800,
      ),
      home: const CurrentWeatherPage(),
    );
  }
}
