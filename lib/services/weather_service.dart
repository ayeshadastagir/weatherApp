import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/astronomy.dart';
import '../models/forecast_day.dart';
import '../models/weather_model.dart';
class WeatherService {
  static const String _apiKey = '38d0f96bbd1546b8bfb62112250307';
  static const String _baseUrl = 'https://api.weatherapi.com/v1';

  Future<Weather> fetchCurrentWeather(String city) async {
    final url = Uri.parse('$_baseUrl/current.json?key=$_apiKey&q=$city');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Weather.fromJson(data);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<List<ForecastDay>> fetchForecast(String city, int days) async {
    final url = Uri.parse('$_baseUrl/forecast.json?key=$_apiKey&q=$city&days=$days');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final forecastList = data['forecast']['forecastday'] as List;
      return forecastList.map((day) => ForecastDay.fromJson(day)).toList();
    } else {
      throw Exception('Failed to load forecast');
    }
  }

  Future<List<String>> searchCities(String query) async {
    if (query.isEmpty) return [];

    final url = Uri.parse('$_baseUrl/search.json?key=$_apiKey&q=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((city) => '${city['name']}, ${city['region']}, ${city['country']}').toList();
    } else {
      return [];
    }
  }

  Future<Astronomy> fetchAstronomy(String city) async {
    final url = Uri.parse('$_baseUrl/astronomy.json?key=$_apiKey&q=$city');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Astronomy.fromJson(data);
    } else {
      throw Exception('Failed to load astronomy data');
    }
  }

  Future<Weather> fetchAutoLocationWeather() async {
    final url = Uri.parse('$_baseUrl/current.json?key=$_apiKey&q=auto:ip');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Weather.fromJson(data);
    } else {
      throw Exception('Failed to load location weather');
    }
  }

}