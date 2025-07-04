import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/weather_controller.dart';

class AstronomyInfo extends StatelessWidget {
  const AstronomyInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WeatherController>();

    return Obx(() {
      if (controller.astronomy.value == null) return const SizedBox.shrink();

      final astronomy = controller.astronomy.value!;

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
              'Sun & Moon',
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
                  child: _buildAstronomyItem(
                    Icons.wb_sunny,
                    'Sunrise',
                    astronomy.sunrise,
                  ),
                ),
                Expanded(
                  child: _buildAstronomyItem(
                    Icons.wb_sunny_outlined,
                    'Sunset',
                    astronomy.sunset,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _buildAstronomyItem(
                    Icons.nightlight,
                    'Moonrise',
                    astronomy.moonrise,
                  ),
                ),
                Expanded(
                  child: _buildAstronomyItem(
                    Icons.nightlight_outlined,
                    'Moonset',
                    astronomy.moonset,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Center(
              child: _buildAstronomyItem(
                Icons.circle,
                'Moon Phase',
                astronomy.moonPhase,
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildAstronomyItem(IconData icon, String label, String value) {
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