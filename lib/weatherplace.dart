import 'package:flutter/material.dart';
import 'package:assignment1/weather_service.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherPlace extends StatefulWidget {
  const WeatherPlace({super.key});

  @override
  State<WeatherPlace> createState() => _WeatherPlaceState();
}

class _WeatherPlaceState extends State<WeatherPlace> {
  TextEditingController location =
      TextEditingController(); // Creating a TextEditingController to get the input
  String weatherInfo = ''; // Creating string var to store the weather info.
  bool isLoading = false; // Creating a bool var to show data loading status

  void fetchWeather() async {
    // Using get function from the weather_service.dart to fetch the weather data in this class/dart file.
    // And using setState to update the UI based on the Temp, Condition and Wind Speed.
    // Using an error handler to catch any errors that might occur.
    setState(() => isLoading = true);
    try {
      final weatherData = await WeatherService().getWeather(location.text);
      setState(() {
        weatherInfo = 'Temperature: ${weatherData['temperature']}°C\n'
            'Condition: ${weatherData['condition']}\n'
            'Wind Speed: ${weatherData['windSpeed']} km/h';
      });
    } catch (e) {
      setState(() {
        weatherInfo = 'Error: ${e.toString()}';
      });
    } finally {
      setState(
          () => isLoading = false); // reset isLoading as loading has completed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextField(
            controller: location,
            decoration: InputDecoration(
              labelText: 'City',
              labelStyle: GoogleFonts.poppins(),
              border: const OutlineInputBorder(),
              suffixIcon: isLoading
                  ? Transform.scale(
                      scale:
                          0.5, // Adjusting scale to fit of loader to icon size
                      child: const CircularProgressIndicator(
                          strokeWidth: 2), // Thinner stroke width
                    )
                  : IconButton(
                      icon: const Icon(Icons
                          .search), // Search icon and when pressed initates fetchWeather
                      onPressed: fetchWeather,
                    ),
            ),
            onSubmitted: (value) => fetchWeather(),
            style: GoogleFonts.poppins(),
          ),
          const SizedBox(height: 20),
          if (weatherInfo.isNotEmpty)
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  weatherInfo,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(fontSize: 18),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
