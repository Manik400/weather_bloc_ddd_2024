import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc_ddd_2024/Presentation_/widgets/CitySelectionUI.dart';

import '../Bloc/weather_bloc.dart';
import '../widgets/Weather_Screen_UI.dart';

class WeatherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Use existing WeatherBloc instance or create one if not available
    WeatherBloc weatherBloc = context.read<WeatherBloc>();

    // Trigger BLoC event to get weather by location when the page is loaded
    weatherBloc.add(GetWeatherByLocationEvent());

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherInitialState || state is WeatherLoadingState) {
            // Initial or Loading state
            return Center(child: CircularProgressIndicator());
          } else if (state is WeatherLoadedState) {
            // Loaded state
            return WeatherDisplay(weather: state.weather);
          } else if (state is WeatherErrorState) {
            // Error state
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Open a new screen to ask for city name with the same WeatherBloc instance
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: weatherBloc,
                child: CitySelectionUI(),
              ),
            ),
          );
        },
        child: Icon(Icons.location_city),
      ),
    );
  }
}
