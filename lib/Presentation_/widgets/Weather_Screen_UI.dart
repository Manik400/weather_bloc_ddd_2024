import 'dart:ui';

import 'package:flutter/material.dart';

import '../../Domain_/entities/weather.dart';

class WeatherDisplay extends StatelessWidget {
  final Weather weather;

  WeatherDisplay({required this.weather});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(10.0), // Optional: Add rounded corners
        child: BackdropFilter(
          filter: ImageFilter.blur(
              sigmaX: 5.0,
              sigmaY: 5.0), // Adjust sigmaX and sigmaY for blur intensity
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0x77005AA7), // Start color with alpha (translucent)
                  Color(0x77FFFDE4), // End color with alpha (translucent)
                ],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'City: ',
                      style: TextStyle(
                        fontSize: 20, // Set a reasonable font size
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${weather.cityName}',
                      style: TextStyle(
                        fontSize: 22, // Set a reasonable font size
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Temperature: ',
                      style: TextStyle(
                        fontSize: 20, // Set a reasonable font size
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${weather.temperature}°C',
                      style: TextStyle(
                        fontSize: 22, // Set a reasonable font size
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
