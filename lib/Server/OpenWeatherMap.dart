import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Map<String, dynamic>> getWeather(double latitude, double longitude) async {
    final String apiEndpoint = 'http://api.openweathermap.org/data/2.5/weather';

    final Map<String, String> parameters = {
      'lat': latitude.toString(),
      'lon': longitude.toString(),
      'appid': '1386548992bf5683485a2f35deb702e1',
      'units': 'metric', // You can change the units to 'imperial' for Fahrenheit
    };

    final Uri uri = Uri.parse(apiEndpoint).replace(queryParameters: parameters);

    final http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<Map<String, dynamic>> getWeatherByCity(String cityName) async {
    final String apiEndpoint = 'http://api.openweathermap.org/data/2.5/weather';

    final Map<String, String> parameters = {
      'q': cityName,
      'appid': '4088f34c07652a38e41e5271e2b702cd',
      'units': 'metric', // You can change the units to 'imperial' for Fahrenheit
    };

    final Uri uri = Uri.parse(apiEndpoint).replace(queryParameters: parameters);

    final http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

}
