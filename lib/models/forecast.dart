class Forecast {
  final DateTime date;
  final double temperature;
  final double minTemp;
  final double maxTemp;
  final String condition;
  final String iconCode;

  Forecast({
    required this.date,
    required this.temperature,
    required this.minTemp,
    required this.maxTemp,
    required this.condition,
    required this.iconCode,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      temperature: json['main']['temp'].toDouble(),
      minTemp: json['main']['temp_min'].toDouble(),
      maxTemp: json['main']['temp_max'].toDouble(),
      condition: json['weather'][0]['main'],
      iconCode: json['weather'][0]['icon'],
    );
  }
}