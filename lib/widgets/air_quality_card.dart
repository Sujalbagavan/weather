import 'package:flutter/material.dart';
import '../models/air_quality.dart';
import '../utils/constants.dart';

class AirQualityCard extends StatelessWidget {
  final AirQuality airQuality;

  const AirQualityCard({Key? key, required this.airQuality}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
              'AIR QUALITY',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: airQuality.aqiColor.withOpacity(0.2),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: airQuality.aqiColor,
                      width: 2,
                    ),
                  ),
                  child: Text(
                    airQuality.aqi.toString(),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: airQuality.aqiColor,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      airQuality.aqiDescription,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Air quality index is ${airQuality.aqi}, which is similar to yesterday',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Components:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildPollutantItem('CO', '${airQuality.co.toStringAsFixed(1)} μg/m³'),
                _buildPollutantItem('NO', '${airQuality.no.toStringAsFixed(1)} μg/m³'),
                _buildPollutantItem('NO₂', '${airQuality.no2.toStringAsFixed(1)} μg/m³'),
                _buildPollutantItem('O₃', '${airQuality.o3.toStringAsFixed(1)} μg/m³'),
                _buildPollutantItem('SO₂', '${airQuality.so2.toStringAsFixed(1)} μg/m³'),
                _buildPollutantItem('PM2.5', '${airQuality.pm25.toStringAsFixed(1)} μg/m³'),
                _buildPollutantItem('PM10', '${airQuality.pm10.toStringAsFixed(1)} μg/m³'),
                _buildPollutantItem('NH₃', '${airQuality.nh3.toStringAsFixed(1)} μg/m³'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPollutantItem(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}