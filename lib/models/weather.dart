class Weather {
  final String cityName;
  final double temperature;
  final double feelsLike;
  final String condition;
  final String description;
  final int humidity;
  final double windSpeed;
  final DateTime sunrise;
  final DateTime sunset;
  final int pressure;
  final int visibility;
  final double dewPoint;
  final String iconCode;
  final double longitude;
  final double latitude; // Added latitude

  Weather({
    required this.cityName,
    required this.temperature,
    required this.feelsLike,
    required this.condition,
    required this.description,
    required this.humidity,
    required this.windSpeed,
    required this.sunrise,
    required this.sunset,
    required this.pressure,
    required this.visibility,
    required this.dewPoint,
    required this.iconCode,
    required this.longitude,
    required this.latitude, // Added latitude
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      feelsLike: json['main']['feels_like'].toDouble(),
      condition: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
      sunrise: DateTime.fromMillisecondsSinceEpoch(json['sys']['sunrise'] * 1000),
      sunset: DateTime.fromMillisecondsSinceEpoch(json['sys']['sunset'] * 1000),
      pressure: json['main']['pressure'],
      visibility: json['visibility'] ~/ 1000, // convert to km
      dewPoint: json['main']['temp_min'].toDouble(),
      iconCode: json['weather'][0]['icon'],
      longitude: json['coord']['lon'].toDouble(), // Added longitude
      latitude: json['coord']['lat'].toDouble(), // Added latitude
    );
  }
}