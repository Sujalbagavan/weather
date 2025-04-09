import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather.dart';
import '../models/forecast.dart';
import '../models/air_quality.dart';
import '../models/hourly_forecast.dart';

class WeatherService {
  final String apiKey;

  WeatherService({required this.apiKey});

  Future<Weather> fetchCurrentWeather(String cityName) async {
    try {
      final url = 'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric';
      print('Attempting API call to: $url'); // Debug log
      
      final response = await http.get(Uri.parse(url));
      print('API Response Status Code: ${response.statusCode}'); // Debug log
      print('API Response Body: ${response.body}'); // Debug log

      if (response.statusCode == 200) {
        return Weather.fromJson(json.decode(response.body));
      } else if (response.statusCode == 401) {
        throw Exception('Invalid API key - Please check your API key configuration');
      } else if (response.statusCode == 404) {
        throw Exception('City not found');
      } else {
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error details: $e'); // Debug log
      throw Exception('Network error: ${e.toString()}');
    }
  }
  Future<List<HourlyForecast>> fetchHourlyForecast(String cityName) async {
  final response = await http.get(
    Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$apiKey&units=metric&cnt=8'), // Next 8 hours
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data['list'].map<HourlyForecast>((item) => HourlyForecast.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load hourly forecast data');
  }
}

  Future<AirQuality> fetchAirQuality(double lat, double lon) async {
  final response = await http.get(
    Uri.parse(
        'https://api.openweathermap.org/data/2.5/air_pollution?lat=$lat&lon=$lon&appid=$apiKey'),
  );

  if (response.statusCode == 200) {
    return AirQuality.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load air quality data');
  }
}

  Future<List<Forecast>> fetchFiveDayForecast(String cityName) async {
    final response = await http.get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$apiKey&units=metric&cnt=40'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Forecast> forecasts = [];
      
      // Get one forecast per day (every 24 hours)
      for (int i = 0; i < data['list'].length; i += 8) {
        forecasts.add(Forecast.fromJson(data['list'][i]));
      }
      
      return forecasts;
    } else {
      throw Exception('Failed to load forecast data');
    }
  }
}