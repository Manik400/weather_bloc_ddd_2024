import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc_ddd_2024/Presentation_/widgets/CitySelectionUI.dart';

import '../Bloc/weather_bloc.dart';


class CitySelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: BlocProvider.of<WeatherBloc>(context, listen: false),
        child: CitySelectionUI(), // Replace with your actual CitySelection widget
      ),
    );
  }
}