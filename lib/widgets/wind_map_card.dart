import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../utils/constants.dart';

class WindMapCard extends StatelessWidget {
  final double windSpeed;
  final String cityName;

  const WindMapCard({
    Key? key,
    required this.windSpeed,
    required this.cityName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: AppDimens.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.borderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'WIND MAP',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  '${windSpeed.toStringAsFixed(1)} km/h',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: CustomPaint(
                size: const Size(double.infinity, 200),
                painter: WindMapPainter(windSpeed: windSpeed),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                cityName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WindMapPainter extends CustomPainter {
  final double windSpeed;
  
  WindMapPainter({required this.windSpeed});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primaryColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Draw wind direction arrows
    final numberOfArrows = (windSpeed / 5).ceil();
    final arrowSpacing = size.width / (numberOfArrows + 1);

    for (var i = 0; i < numberOfArrows; i++) {
      final startX = arrowSpacing * (i + 1);
      final startY = size.height / 2;
      
      // Draw arrow line
      canvas.drawLine(
        Offset(startX - 20, startY),
        Offset(startX + 20, startY),
        paint,
      );

      // Draw arrow head
      final path = Path();
      path.moveTo(startX + 20, startY);
      path.lineTo(startX + 15, startY - 5);
      path.moveTo(startX + 20, startY);
      path.lineTo(startX + 15, startY + 5);
      canvas.drawPath(path, paint);
    }

    // Draw wind speed indicator
    final speedIndicator = Paint()
      ..color = AppColors.primaryColor.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    final indicatorHeight = (windSpeed / 50) * size.height;
    canvas.drawRect(
      Rect.fromLTWH(0, size.height - indicatorHeight, size.width, indicatorHeight),
      speedIndicator,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}