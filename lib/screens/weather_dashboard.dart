import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../widgets/current_weather.dart';
import '../widgets/forecast_list.dart';
import '../widgets/weather_shimmer.dart';
import '../providers/theme_provider.dart'; // Ensure this file exists and contains the ThemeProvider class
import '../widgets/air_quality_card.dart';
import '../widgets/wind_map_card.dart';
import '../models/hourly_forecast.dart'; // Ensure this file exists and contains the HourlyForecastWidget class
import '../widgets/weather_details.dart';
import '../utils/constants.dart';

class WeatherDashboard extends StatefulWidget {
  const WeatherDashboard({super.key});

  @override
  _WeatherDashboardState createState() => _WeatherDashboardState();
}

class _WeatherDashboardState extends State<WeatherDashboard> {
  final TextEditingController _searchController = TextEditingController();
  bool _showSearchHistory = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WeatherProvider>(context, listen: false).loadLastCity();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Dashboard'),
        backgroundColor: AppColors.primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Show weather alerts dialog
            },
          ),
          IconButton(
            icon: Icon(Provider.of<ThemeProvider>(context).isDarkMode 
              ? Icons.light_mode 
              : Icons.dark_mode),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              setState(() {
                _showSearchHistory = !_showSearchHistory;
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
              if (weatherProvider.currentWeather != null) {
                await weatherProvider.fetchWeather(
                    weatherProvider.currentWeather!.cityName);
              }
            },
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  if (weatherProvider.isLoading && weatherProvider.currentWeather == null)
                    const WeatherShimmer()
                  else if (weatherProvider.error != null)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          weatherProvider.error!,
                          style: TextStyle(color: theme.colorScheme.error),
                        ),
                      ),
                    )
                  else if (weatherProvider.currentWeather != null)
                    Column(
                      children: [
                        CurrentWeatherWidget(
                            weather: weatherProvider.currentWeather!),
                        const SizedBox(height: 8),
                        HourlyForecastWidget(
                            forecasts: weatherProvider.hourlyForecasts),
                        const SizedBox(height: 8),
                        WeatherDetailsWidget(
                            weather: weatherProvider.currentWeather!),
                        const SizedBox(height: 8),
                        if (weatherProvider.airQuality != null)
                          AirQualityCard(
                              airQuality: weatherProvider.airQuality!),
                        const SizedBox(height: 8),
                        WindMapCard(
                          windSpeed: weatherProvider.currentWeather!.windSpeed,
                          cityName: weatherProvider.currentWeather!.cityName,
                        ),
                        const SizedBox(height: 8),
                        ForecastListWidget(forecasts: weatherProvider.forecasts),
                        const SizedBox(height: 20),
                      ],
                    )
                  else
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.location_on,
                                size: 64, color: Colors.grey),
                            const SizedBox(height: 16),
                            Text(
                              'Search for a city to see weather information',
                              style: theme.textTheme.headlineSmall?.copyWith(
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (_showSearchHistory)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search city...',
                        filled: true,
                        fillColor: theme.cardColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            if (_searchController.text.isNotEmpty) {
                              weatherProvider.fetchWeather(_searchController.text);
                              setState(() {
                                _showSearchHistory = false;
                              });
                            }
                          },
                        ),
                      ),
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          weatherProvider.fetchWeather(value);
                          setState(() {
                            _showSearchHistory = false;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    if (weatherProvider.searchHistory.isNotEmpty)
                      ...weatherProvider.searchHistory.map((city) => ListTile(
                            leading: const Icon(Icons.history),
                            title: Text(city),
                            trailing: IconButton(
                              icon: const Icon(Icons.north_west),
                              onPressed: () {
                                _searchController.text = city;
                              },
                            ),
                            onTap: () {
                              weatherProvider.fetchWeather(city);
                              setState(() {
                                _showSearchHistory = false;
                              });
                            },
                          ))
                    else
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'No search history yet',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}