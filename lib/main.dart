import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:weather_app/views/home_view.dart';
import 'package:weather_app/views/search_view.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetWeatherCubit(),
      child: Builder(
        builder: (context) => BlocBuilder<GetWeatherCubit, WeatherState>(
          builder: (context, state) => MaterialApp(
            theme: ThemeData(
              primarySwatch: getThemeColor(
                  BlocProvider.of<GetWeatherCubit>(context)
                      .weatherModel
                      ?.weatherCondition),
            ),
            debugShowCheckedModeBanner: false,
            initialRoute: HomeView.id,
            routes: {
              HomeView.id: (context) => const HomeView(),
              SearchView.id: (context) => const SearchView(),
            },
          ),
        ),
      ),
    );
  }
}

MaterialColor getThemeColor(String? condition) {
  if (condition == null) {
    return Colors.blue;
  }
  switch (condition) {
    // Sunny conditions
    case 'Sunny':
    case 'Clear':
    case 'Fair':
      return Colors.orange;

    // Partly cloudy conditions
    case 'Partly cloudy':
    case 'Mostly sunny':
    case 'Sunny intervals':
      return Colors.lightBlue;

    // Cloudy conditions
    case 'Cloudy':
    case 'Overcast':
    case 'Dull':
      return Colors.grey;

    // Rainy conditions
    case 'Rain':
    case 'Drizzle':
    case 'Light rain':
    case 'Moderate rain':
    case 'Heavy rain':
      return Colors.lightGreen;

    // Snowy conditions
    case 'Snow':
    case 'Light snow':
    case 'Moderate snow':
    case 'Heavy snow':
      return Colors.blue;

    // Thunderstorm conditions
    case 'Thunderstorm':
    case 'Lightning':
    case 'Heavy rain with thunder':
      return Colors.yellow;

    // Other conditions
    default:
      return Colors.grey;
  }
}
