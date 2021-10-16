import 'package:clean_architecture_weather/features/current_weather/presentation/bloc/current_weather_bloc.dart';
import 'package:clean_architecture_weather/features/current_weather/presentation/widgets/widgets.dart';
import 'package:clean_architecture_weather/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentWeatherPage extends StatelessWidget {
  const CurrentWeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Current Weather"),
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<CurrentWeatherBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CurrentWeatherBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
                builder: (context, state) {
                  if (state is Empty) {
                    return const MessageDisplay(message: "Start searching");
                  } else if (state is Loading) {
                    return const LoadingWidget();
                  } else if (state is Loaded) {
                    return CurrentWeatherDisplay(
                      currentWeather: state.current,
                    );
                  } else if (state is Error) {
                    return MessageDisplay(message: state.message);
                  }
                  else{
                    return const Text('');
                  }
                },
              ),
              const SizedBox(height: 20),
              CurrentWeatherControls()
            ],
          ),
        ),
      ),
    );
  }
}
