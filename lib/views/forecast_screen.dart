import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weather_app/controllers/forecast_controller.dart';

class ForecastScreen extends StatelessWidget {
  ForecastScreen({super.key});

  final controller = Get.put(ForecastController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('7-Day Forecast')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.cityController,
                    decoration: InputDecoration(
                      hintText: 'Enter city name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    final city = controller.cityController.text.trim();
                    if (city.isNotEmpty) {
                      controller.getForecast(city);
                      FocusScope.of(context).unfocus(); // dismiss keyboard
                    }
                  },
                  child: const Text('Search'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.error.isNotEmpty) {
                  return Center(child: Text(controller.error.value));
                }

                return SfCartesianChart(
                  backgroundColor: Colors.white,
                  plotAreaBackgroundColor: Colors.blue.shade50,
                  primaryXAxis: CategoryAxis(
                    axisLine: const AxisLine(width: 1, color: Colors.black54),
                    majorGridLines: const MajorGridLines(width: 0),
                    labelStyle: const TextStyle(color: Colors.black87),
                  ),
                  primaryYAxis: NumericAxis(
                    axisLine: const AxisLine(width: 1, color: Colors.black54),
                    majorGridLines: MajorGridLines(
                      color: Colors.grey.shade300,
                      dashArray: [5, 5],
                    ),
                    labelStyle: const TextStyle(color: Colors.black87),
                  ),
                  title: ChartTitle(
                    text: 'Avg Temperature (°C)',
                    textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  legend: Legend(isVisible: true),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <CartesianSeries>[
                    LineSeries<Map<String, dynamic>, String>(
                      dataSource: controller.forecast,
                      xValueMapper: (data, _) => data['date'],
                      yValueMapper: (data, _) => data['temp'],
                      name: 'Temp',
                      color: Colors.purple,
                      width: 3,
                      markerSettings: const MarkerSettings(
                        isVisible: true,
                        height: 8,
                        width: 8,
                        shape: DataMarkerType.circle,
                        color: Colors.white,
                        borderColor: Colors.purple,
                        borderWidth: 2,
                      ),
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        textStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                        labelAlignment: ChartDataLabelAlignment.top,
                      ),
                    ),
                  ],
                );

              }),
            ),
          ],
        ),
      ),
    );
  }
}
