import 'package:flutter/material.dart';

class WeatherAlertCard extends StatelessWidget {
  final String alertType;
  final String description;
  final DateTime startTime;
  final DateTime endTime;

  const WeatherAlertCard({
    Key? key,
    required this.alertType,
    required this.description,
    required this.startTime,
    required this.endTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Icon(
          Icons.warning_amber_rounded,
          color: Colors.red,
        ),
        title: Text(alertType),
        subtitle: Text(description),
        trailing: Text(
          '${startTime.hour}:${startTime.minute} - ${endTime.hour}:${endTime.minute}',
        ),
      ),
    );
  }
}