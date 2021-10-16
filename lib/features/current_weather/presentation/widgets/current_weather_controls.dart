import 'package:clean_architecture_weather/features/current_weather/domain/usecases/fetch_current_weather_by_query.dart';
import 'package:clean_architecture_weather/features/current_weather/presentation/bloc/current_weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentWeatherControls extends StatefulWidget {

  @override
  _CurrentWeatherControlsState createState() => _CurrentWeatherControlsState();
}

class _CurrentWeatherControlsState extends State<CurrentWeatherControls> {
  final controller = TextEditingController();
  String inputStr = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input a number',
          ),
          onChanged: (value) {
            inputStr = value;
          },
          onSubmitted: (_) {
            dispatchConcrete();
          },
        ),
        const SizedBox(height: 10),
        Row(
          children: <Widget>[
            Expanded(
              child: MaterialButton(
                child: const Text('Search'),
                textTheme: ButtonTextTheme.primary,
                onPressed: dispatchConcrete,
              ),
            ),
          ],
        )
      ],
    );
  }

  void dispatchConcrete() {
    controller.clear();
    BlocProvider.of<CurrentWeatherBloc>(context)
        .add(FetchCurrentWeatherForQuery(inputStr));
  }
}