import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../controllers/weather_controller.dart';

class ForecastChart extends StatelessWidget {
  const ForecastChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WeatherController>();

    return Obx(() {
      if (controller.isForecastLoading.value) {
        return Container(
          height: 300,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
          ),
          child: const Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        );
      }

      if (controller.forecast.isEmpty) return const SizedBox.shrink();

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
              'Temperature Forecast',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            SizedBox(
              height: 250,
              child: SfCartesianChart(
                backgroundColor: Colors.transparent,
                plotAreaBackgroundColor: Colors.transparent,
                primaryXAxis: CategoryAxis(
                  axisLine: const AxisLine(width: 0),
                  majorTickLines: const MajorTickLines(size: 0),
                  majorGridLines: const MajorGridLines(width: 0),
                  labelStyle: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                primaryYAxis: NumericAxis(
                  axisLine: const AxisLine(width: 0),
                  majorTickLines: const MajorTickLines(size: 0),
                  majorGridLines: MajorGridLines(
                    color: Colors.white.withValues(alpha: 0.2),
                    width: 1,
                  ),
                  labelStyle: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <CartesianSeries>[
                  // Max Temperature Line
                  SplineSeries<Map<String, dynamic>, String>(
                    name: 'Max Temp',
                    dataSource: controller.forecast.map((forecast) => {
                      'date': _formatDate(forecast.date),
                      'temp': forecast.maxTempC,
                    }).toList(),
                    xValueMapper: (data, _) => data['date'],
                    yValueMapper: (data, _) => data['temp'],
                    color: Colors.red,
                    width: 3,
                    markerSettings: const MarkerSettings(
                      isVisible: true,
                      height: 8,
                      width: 8,
                      shape: DataMarkerType.circle,
                      color: Colors.red,
                      borderColor: Colors.white,
                      borderWidth: 1,
                    ),
                  ),
                  // Min Temperature Line
                  SplineSeries<Map<String, dynamic>, String>(
                    name: 'Min Temp',
                    dataSource: controller.forecast.map((forecast) => {
                      'date': _formatDate(forecast.date),
                      'temp': forecast.minTempC,
                    }).toList(),
                    xValueMapper: (data, _) => data['date'],
                    yValueMapper: (data, _) => data['temp'],
                    color: Colors.lightBlue,
                    width: 3,
                    markerSettings: const MarkerSettings(
                      isVisible: true,
                      height: 8,
                      width: 8,
                      shape: DataMarkerType.circle,
                      color: Colors.lightBlue,
                      borderColor: Colors.white,
                      borderWidth: 1,
                    ),
                  ),
                ],
                legend: Legend(
                  isVisible: true,
                  position: LegendPosition.bottom,
                  textStyle: const TextStyle(color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Forecast Cards
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.forecast.length,
                itemBuilder: (context, index) {
                  final forecast = controller.forecast[index];
                  return Container(
                    width: 100,
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _formatDate(forecast.date),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Image.network(
                          forecast.iconUrl,
                          width: 32,
                          height: 32,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.wb_sunny, color: Colors.white, size: 32);
                          },
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${forecast.maxTempC.round()}°/${forecast.minTempC.round()}°',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${forecast.chanceOfRain.round()}%',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  String _formatDate(String date) {
    final DateTime dateTime = DateTime.parse(date);
    final now = DateTime.now();

    if (dateTime.day == now.day && dateTime.month == now.month && dateTime.year == now.year) {
      return 'Today';
    } else if (dateTime.day == now.add(const Duration(days: 1)).day &&
        dateTime.month == now.add(const Duration(days: 1)).month &&
        dateTime.year == now.add(const Duration(days: 1)).year) {
      return 'Tomorrow';
    } else {
      return '${dateTime.day}/${dateTime.month}';
    }
  }
}
