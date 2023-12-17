import 'package:flutter/material.dart';
import 'package:flutter_location_weather/Screen/HomeScreen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_location_weather/Server/OpenWeatherMap.dart';
import 'package:flutter_location_weather/Screen/Deivice_Location.dart';
import 'package:flutter_location_weather/Screen/Select_City_Location.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final WeatherService weatherService = WeatherService('YOUR_API_KEY');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text('Weather App with Location'),
        // ),
        body: Home(),
      ),
    );
  }
}







