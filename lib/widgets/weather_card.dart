import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/weather_model.dart';
import '../controllers/weather_controller.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;

  const WeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WeatherController>();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          // Location and Time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      weather.city,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${weather.region}, ${weather.country}',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      weather.localTime,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: controller.toggleTemperatureUnit,
                icon: Icon(
                  controller.isCelsius.value ? Icons.thermostat : Icons.device_thermostat,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Weather Icon and Temperature
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                weather.iconUrl,
                width: 80,
                height: 80,
              ),
              const SizedBox(width: 20),
              Obx(() => Text(
                controller.getTemperature(weather.tempC),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 64,
                  fontWeight: FontWeight.w300,
                ),
              )),
            ],
          ),

          const SizedBox(height: 16),

          // Weather Condition
          Text(
            weather.condition,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 8),

          // Feels Like
          Obx(() => Text(
            'Feels like ${controller.getTemperature(weather.feelsLikeC)}',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 14,
            ),
          )),
        ],
      ),
    );
  }
}
