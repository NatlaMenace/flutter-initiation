import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:initiation_project/services/weather_service.dart';
import 'package:initiation_project/themes/text_style.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  final WeatherService weatherService = WeatherService();
  Map<String, dynamic>? weatherData;
  double? exchangeRate;
  final city = 'Limoges';

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    try {
      final data = await weatherService.fetchWeatherData(city);
      setState(() {
        weatherData = data;
      });
    } catch (e) {
      print("Error fetching weather data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white70),
          onPressed: () => context.go('/home'),
        ),
        title: const Text(
          'More Information',
          style: titleTextStyle,
        ),
        backgroundColor: Colors.black87,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: weatherData == null
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'City: ',
                          style: bodyTextStyle,
                        ),
                        TextSpan(
                          text: city,
                          style: labelTextStyle,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Temperature: ',
                          style: bodyTextStyle,
                        ),
                        TextSpan(
                          text:
                              '${(weatherData!["main"]["temp"] - 273.15).toStringAsFixed(1)}°C',
                          style: labelTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
