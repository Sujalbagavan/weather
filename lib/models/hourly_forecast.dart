import 'package:flutter/material.dart';
// Ensure the correct file is imported or define the HourlyForecast class if missing
import '../models/hourly_forecast.dart';
import '../utils/constants.dart';
import 'package:intl/intl.dart';

// Example definition of HourlyForecast if it doesn't exist
class HourlyForecast {
  final String time;
  final double temperature;
  final String condition;
  final String iconCode;

  HourlyForecast({
    required this.time,
    required this.temperature,
    required this.condition,
    required this.iconCode,
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    return HourlyForecast(
      time: DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000)),
      temperature: json['main']['temp'].toDouble(),
      condition: json['weather'][0]['main'],
      iconCode: json['weather'][0]['icon'],
    );
  }
}


class HourlyForecastWidget extends StatelessWidget {
  final List<HourlyForecast> forecasts;

  const HourlyForecastWidget({super.key, required this.forecasts});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'HOURLY FORECAST',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: forecasts.length,
                itemBuilder: (context, index) {
                  final forecast = forecasts[index];
                  return Container(
                    width: 80,
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          forecast.time,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Image.network(
                          'https://openweathermap.org/img/wn/${forecast.iconCode}@2x.png',
                          width: 40,
                          height: 40,
                        ),
                        Text(
                          '${forecast.temperature.round()}°',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}