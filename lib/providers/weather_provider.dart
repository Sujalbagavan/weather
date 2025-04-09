import 'package:flutter/material.dart';
import '../models/weather.dart';
import '../models/forecast.dart';
import '../services/weather_service.dart';
import '../services/storage_service.dart';
import '../models/air_quality.dart';
import '../models/hourly_forecast.dart';

class WeatherProvider with ChangeNotifier {
  final WeatherService weatherService;
  final StorageService storageService;

  WeatherProvider({
    required this.weatherService,
    required this.storageService,
  });

  Weather? _currentWeather;
  List<Forecast> _forecasts = [];
  List<HourlyForecast> _hourlyForecasts = [];
  bool _isLoading = false;
  String? _error;
  List<String> _searchHistory = [];
  AirQuality? _airQuality;

  Weather? get currentWeather => _currentWeather;
  List<Forecast> get forecasts => _forecasts;
  List<HourlyForecast> get hourlyForecasts => _hourlyForecasts;
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<String> get searchHistory => _searchHistory;
  AirQuality? get airQuality => _airQuality;

  Future<void> fetchWeather(String cityName) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currentWeather = await weatherService.fetchCurrentWeather(cityName);
      _hourlyForecasts = await weatherService.fetchHourlyForecast(cityName);
      _forecasts = await weatherService.fetchFiveDayForecast(cityName);
      await storageService.saveLastCity(cityName);
      await storageService.addToSearchHistory(cityName);
      _searchHistory = await storageService.getSearchHistory();
    } catch (e) {
      _error = 'Failed to fetch weather data: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchWeatherWithAirQuality(String cityName) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currentWeather = await weatherService.fetchCurrentWeather(cityName);
      _hourlyForecasts = await weatherService.fetchHourlyForecast(cityName);
      _forecasts = await weatherService.fetchFiveDayForecast(cityName);
      
      // Fetch air quality data
      _airQuality = await weatherService.fetchAirQuality(
        _currentWeather!.latitude, 
        _currentWeather!.longitude
      );
      
      await storageService.saveLastCity(cityName);
      await storageService.addToSearchHistory(cityName);
      _searchHistory = await storageService.getSearchHistory();
    } catch (e) {
      _error = 'Failed to fetch weather data: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadLastCity() async {
    final lastCity = await storageService.getLastCity();
    if (lastCity != null) {
      await fetchWeather(lastCity);
    }
    _searchHistory = await storageService.getSearchHistory();
    notifyListeners();
  }
}