import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_location_weather/Server/OpenWeatherMap.dart';
import 'package:flutter_location_weather/Resources/Colors.dart';
import 'package:flutter_location_weather/Screen/HomeScreen.dart';

class SelfLocation extends StatelessWidget {
  final WeatherService weatherService = WeatherService('YOUR_API_KEY');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Weather Of Your Location'),
          backgroundColor: Colors.blue, // Set your desired background color for the AppBar
          centerTitle: true, // Center the title
        ),
        body: LocationWeatherWidget(weatherService),
      ),
    );
  }
}

class LocationWeatherWidget extends StatefulWidget {
  final WeatherService weatherService;


  LocationWeatherWidget(this.weatherService);

  @override
  _LocationWeatherWidgetState createState() => _LocationWeatherWidgetState();
}

class _LocationWeatherWidgetState extends State<LocationWeatherWidget> {
  String latitude = 'Latitude: ';
  String longitude = 'Longitude: ';
  Map<String, dynamic>? weatherData;
  DateTime currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        latitude = 'Latitude: ${position.latitude}';
        longitude = 'Longitude: ${position.longitude}';
      });

      // Fetch weather data using obtained location
      _getWeather(position.latitude, position.longitude);
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _getWeather(double latitude, double longitude) async {
    try {
      final data = await widget.weatherService.getWeather(latitude, longitude);

      // Extract date information from the API response
      final timestamp = data?['dt'];
      if (timestamp != null) {
        setState(() {
          currentTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
        });
      }

      setState(() {
        weatherData = data;
      });
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    myColors Constrants = myColors();
    return Center(
      child: Container(
        color: Constrants.primaryColor.withOpacity(0.7),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
              },
              child: Container(
                height: 50,
                width: size.width * 0.1,
                decoration: BoxDecoration(
                    color: Constrants.primaryColor.withOpacity(0.7),
                    borderRadius: const BorderRadius.all(Radius.circular(10))
                ),
                child: const Center(
                  child: Text('back', style: TextStyle(color: Colors.white, fontSize: 20),),
                ),
              ),
            ),
            Image.asset('get-started.png'),
            if (weatherData != null)
              Column(
                children: [
                  Text('Date: ${_formatDate(currentTime)} ${_formatTime(currentTime)}'),
                  Text('Temperature: ${weatherData?['main']?['temp']}°C'),
                  Text('Humidity: ${weatherData?['main']?['humidity']}%'),
                  Text('Wind Speed: ${weatherData?['wind']?['speed']} m/s'),
                  Text('Max Temperature: ${weatherData?['main']?['temp_max']}°C'),
                  Text('Min Temperature: ${weatherData?['main']?['temp_min']}°C'),
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.20,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          "http://openweathermap.org/img/wn/${weatherData?['weather']?[0]?['icon']}@2x.png",
                        ),
                      ),
                    ),
                  ),
                  Text(' ${weatherData?['weather']?[0]?['description']}'),

                ],
              ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    int hour = dateTime.hour;
    return '${hourOfPeriod(hour)}:${dateTime.minute.toString().padLeft(2, '0')} ${periodOfDay(hour)}';
  }

  String _formatDate(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  String hourOfPeriod(int hour) {
    return (hour == 0 || hour == 12) ? '12' : (hour % 12).toString();
  }

  String periodOfDay(int hour) {
    return hour < 12 ? 'AM' : 'PM';
  }
}
