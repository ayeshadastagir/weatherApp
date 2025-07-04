import 'package:flutter/material.dart';
import '../models/weather_model.dart';

class WeatherDetails extends StatelessWidget {
  final Weather weather;

  const WeatherDetails({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Weather Details',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _buildDetailItem(
                  Icons.water_drop,
                  'Humidity',
                  '${weather.humidity.round()}%',
                ),
              ),
              Expanded(
                child: _buildDetailItem(
                  Icons.air,
                  'Wind Speed',
                  '${weather.windKph.round()} km/h',
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _buildDetailItem(
                  Icons.compress,
                  'Pressure',
                  '${weather.pressureMb.round()} mb',
                ),
              ),
              Expanded(
                child: _buildDetailItem(
                  Icons.visibility,
                  'Visibility',
                  '${weather.visibilityKm.round()} km',
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _buildDetailItem(
                  Icons.wb_sunny,
                  'UV Index',
                  '${weather.uvIndex.round()}',
                ),
              ),
              Expanded(
                child: _buildDetailItem(
                  Icons.navigation,
                  'Wind Direction',
                  weather.windDir,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 12,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
