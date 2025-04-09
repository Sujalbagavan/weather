import 'package:flutter/material.dart';

class AirQuality {
  final int aqi;
  final double co;
  final double no;
  final double no2;
  final double o3;
  final double so2;
  final double pm25;
  final double pm10;
  final double nh3;

  AirQuality({
    required this.aqi,
    required this.co,
    required this.no,
    required this.no2,
    required this.o3,
    required this.so2,
    required this.pm25,
    required this.pm10,
    required this.nh3,
  });

  factory AirQuality.fromJson(Map<String, dynamic> json) {
    return AirQuality(
      aqi: json['list'][0]['main']['aqi'],
      co: json['list'][0]['components']['co'].toDouble(),
      no: json['list'][0]['components']['no'].toDouble(),
      no2: json['list'][0]['components']['no2'].toDouble(),
      o3: json['list'][0]['components']['o3'].toDouble(),
      so2: json['list'][0]['components']['so2'].toDouble(),
      pm25: json['list'][0]['components']['pm2_5'].toDouble(),
      pm10: json['list'][0]['components']['pm10'].toDouble(),
      nh3: json['list'][0]['components']['nh3'].toDouble(),
    );
  }

  String get aqiDescription {
    switch (aqi) {
      case 1:
        return 'Good';
      case 2:
        return 'Fair';
      case 3:
        return 'Moderate';
      case 4:
        return 'Poor';
      case 5:
        return 'Very Poor';
      default:
        return 'Unknown';
    }
  }

  Color get aqiColor {
    switch (aqi) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.lightGreen;
      case 3:
        return Colors.yellow;
      case 4:
        return Colors.orange;
      case 5:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}