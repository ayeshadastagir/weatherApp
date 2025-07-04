import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../services/weather_service.dart';

class ForecastController extends GetxController {
  final WeatherService _service = WeatherService();
  final cityController = TextEditingController();

  var forecast = <Map<String, dynamic>>[].obs;

  var isLoading = true.obs;
  var error = ''.obs;

  @override
  void onInit() {
    cityController.text = 'islamabad';
    super.onInit();
  }

  void getForecast(String city) async {
    try {
      isLoading(true);
      error('');
      await _service.fetchForecast(cityController.text.trim(), 14);

    } catch (e) {
      error('Failed to load data');
    } finally {
      isLoading(false);
    }
  }
}