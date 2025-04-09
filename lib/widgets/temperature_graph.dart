import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/hourly_forecast.dart';

class TemperatureGraph extends StatelessWidget {
  final List<HourlyForecast> forecasts;

  const TemperatureGraph({Key? key, required this.forecasts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: forecasts.asMap().entries.map((entry) {
                return FlSpot(
                  entry.key.toDouble(),
                  entry.value.temperature,
                );
              }).toList(),
              isCurved: true,
              color: Theme.of(context).primaryColor,
              barWidth: 2,
              dotData: FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}