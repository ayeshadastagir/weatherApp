import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/weather_controller.dart';
import '../widgets/weather_card.dart';
import '../widgets/forecast_chart.dart';
import '../widgets/weather_details.dart';
import '../widgets/astronomy_info.dart';
import '../widgets/weather_search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WeatherController());

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF077A7D),
              Color(0xFFDDA853),
              Color(0xFF0984e3),
            ],
          ),
        ),
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              if (controller.currentWeather.value != null) {
                await controller.loadWeather(controller.currentWeather.value!.city);
              }
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Search Bar
                  const WeatherSearchBar(),
                  const SizedBox(height: 20),

                  // Current Weather Card
                  Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      );
                    }

                    if (controller.error.isNotEmpty) {
                      return Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          controller.error.value,
                          style: TextStyle(color: Colors.red.shade700),
                        ),
                      );
                    }

                    if (controller.currentWeather.value != null) {
                      return WeatherCard(weather: controller.currentWeather.value!);
                    }

                    return const SizedBox.shrink();
                  }),

                  const SizedBox(height: 20),

                  // Weather Details
                  Obx(() {
                    if (controller.currentWeather.value != null) {
                      return WeatherDetails(weather: controller.currentWeather.value!);
                    }
                    return const SizedBox.shrink();
                  }),

                  const SizedBox(height: 20),

                  // Astronomy Info
                  const AstronomyInfo(),

                  const SizedBox(height: 20),

                  // Forecast Days Selector
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Forecast Days:',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        ...([3, 4, 5, 6, 7].map((days) => Obx(() => GestureDetector(
                          onTap: () => controller.changeForecastDays(days),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: controller.selectedForecastDays.value == days
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white),
                            ),
                            child: Text(
                              '$days',
                              style: TextStyle(
                                color: controller.selectedForecastDays.value == days
                                    ? Colors.blue
                                    : Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )))),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Forecast Chart
                  const ForecastChart(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}