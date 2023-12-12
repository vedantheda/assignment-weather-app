import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey =
      'bb008bd8ea87985994e22f7fa22053f2'; // I can use .env to hide this API key but have not done it for the assignment.

  Future<Map<String, dynamic>> getWeather(String city) async {
    // using http module to fetch the weather data from the API.
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Decoding response body and returnong the data.
      final data = json.decode(response.body);
      return {
        'temperature': data['main']['temp'],
        'condition': data['weather'][0]['main'],
        'windSpeed': data['wind']['speed']
      };
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
