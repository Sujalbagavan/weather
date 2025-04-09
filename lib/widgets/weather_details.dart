import 'package:flutter/material.dart';
import '../models/weather.dart';
import '../utils/constants.dart';

class WeatherDetailsWidget extends StatelessWidget {
  final Weather weather;

  const WeatherDetailsWidget({super.key, required this.weather});

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
          children: [
            const Text(
              'WEATHER DETAILS',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 3,
              children: [
                _buildDetailItem(Icons.thermostat, 'Feels Like', '${weather.feelsLike.round()}°'),
                _buildDetailItem(Icons.water_drop, 'Humidity', '${weather.humidity}%'),
                _buildDetailItem(Icons.air, 'Wind Speed', '${weather.windSpeed.round()} km/h'),
                _buildDetailItem(Icons.compress, 'Pressure', '${weather.pressure} hPa'),
                _buildDetailItem(Icons.visibility, 'Visibility', '${weather.visibility} km'),
                _buildDetailItem(Icons.water, 'Dew Point', '${weather.dewPoint.round()}°'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryColor),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}