import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/forecast.dart';
import '../utils/constants.dart';

class ForecastListWidget extends StatelessWidget {
  final List<Forecast> forecasts;

  const ForecastListWidget({super.key, required this.forecasts});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('EEE');

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
              '5-Day Forecast',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: forecasts.length,
                itemBuilder: (context, index) {
                  final forecast = forecasts[index];
                  return Container(
                    width: 100,
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
                          index == 0 ? 'Today' : dateFormat.format(forecast.date),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Image.network(
                          'https://openweathermap.org/img/wn/${forecast.iconCode}@2x.png',
                          width: 50,
                          height: 50,
                        ),
                        Text(
                          '${forecast.maxTemp.round()}°',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${forecast.minTemp.round()}°',
                          style: const TextStyle(
                            color: Colors.grey,
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