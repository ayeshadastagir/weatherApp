import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/astronomy.dart';
import '../models/forecast_day.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';

class WeatherController extends GetxController {
  final WeatherService _service = WeatherService();

  final cityController = TextEditingController();
  final searchController = TextEditingController();

  var currentWeather = Rxn<Weather>();
  var forecast = <ForecastDay>[].obs;
  var astronomy = Rxn<Astronomy>();
  var searchResults = <String>[].obs;
  var historicalWeather = Rxn<Weather>();

  var isLoading = false.obs;
  var isForecastLoading = false.obs;
  var isAstronomyLoading = false.obs;
  var isSearching = false.obs;
  var error = ''.obs;

  var selectedForecastDays = 3.obs;
  var isCelsius = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadAutoLocationWeather();

    // Debounce search
    searchController.addListener(() {
      if (searchController.text.length > 2) {
        searchCities(searchController.text);
      } else {
        searchResults.clear();
      }
    });
  }

  Future<void> loadAutoLocationWeather() async {
    try {
      isLoading(true);
      error('');
      final weather = await _service.fetchAutoLocationWeather();
      currentWeather.value = weather;
      cityController.text = weather.city;
      await loadForecast(weather.city);
      await loadAstronomy(weather.city);
    } catch (e) {
      error('Failed to load location weather');
    } finally {
      isLoading(false);
    }
  }

  Future<void> loadWeather(String city) async {
    try {
      isLoading(true);
      error('');
      final weather = await _service.fetchCurrentWeather(city);
      currentWeather.value = weather;
      cityController.text = city;
      await loadForecast(city);
      await loadAstronomy(city);
    } catch (e) {
      error('City not found or network error');
    } finally {
      isLoading(false);
    }
  }

  Future<void> loadForecast(String city) async {
    try {
      isForecastLoading(true);
      final data = await _service.fetchForecast(city, selectedForecastDays.value);
      forecast.assignAll(data);
    } catch (e) {
      throw Exception('$e');
    } finally {
      isForecastLoading(false);
    }
  }

  Future<void> loadAstronomy(String city) async {
    try {
      isAstronomyLoading(true);
      final data = await _service.fetchAstronomy(city);
      astronomy.value = data;
    } catch (e) {
      throw Exception('Astronomy error: $e');
    } finally {
      isAstronomyLoading(false);
    }
  }

  Future<void> searchCities(String query) async {
    try {
      isSearching(true);
      final results = await _service.searchCities(query);
      searchResults.assignAll(results);
    } catch (e) {
      throw Exception('Search error: $e');
    } finally {
      isSearching(false);
    }
  }

  void toggleTemperatureUnit() {
    isCelsius.toggle();
  }

  void changeForecastDays(int days) {
    selectedForecastDays.value = days;
    if (currentWeather.value != null) {
      loadForecast(currentWeather.value!.city);
    }
  }

  String getTemperature(double celsius) {
    if (isCelsius.value) {
      return '${celsius.round()}°C';
    } else {
      return '${(celsius * 9/5 + 32).round()}°F';
    }
  }

  @override
  void onClose() {
    cityController.dispose();
    searchController.dispose();
    super.onClose();
  }
}