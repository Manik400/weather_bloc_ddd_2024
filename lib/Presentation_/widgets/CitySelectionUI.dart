import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc_ddd_2024/Presentation_/widgets/Weather_Screen_UI.dart';
import 'package:weather_bloc_ddd_2024/Domain_/entities/weather.dart';
import '../Bloc/weather_bloc.dart';

class CitySelectionUI extends StatefulWidget {
  const CitySelectionUI({super.key});

  @override
  State<CitySelectionUI> createState() => _CitySelectionUIState();
}

class _CitySelectionUIState extends State<CitySelectionUI> {
  final TextEditingController _cityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('City Selection'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(labelText: 'Enter City Name'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                String cityName = _cityController.text;
                if (cityName.isNotEmpty) {
                  // Trigger BLoC event to get weather by city
                  context.read<WeatherBloc>().add(GetWeatherByCityEvent(cityName));
                  await Future.delayed(Duration(seconds: 1));
                  Navigator.pop(context);
                }
              },
              child: Text('Get Weather'),
            ),
          ],
        ),
      ),
    );
  }
}
