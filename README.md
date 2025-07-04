# Weather App 🌦️

A clean and simple Flutter-based weather application that fetches real-time and forecast weather data using the [WeatherAPI](https://www.weatherapi.com/docs/).

## 🔗 API Used
- **WeatherAPI**: https://www.weatherapi.com/docs/

## 🚀 Features Implemented

- 🌍 **Current Weather**: Get real-time weather details for any city.
- 📅 **Forecast**: View 3-day weather forecast data.
- 🔍 **City Search**: Search cities with autocomplete using `/search.json`.
- ☀️ **Astronomy Info**: Get sunrise and sunset times via `/astronomy.json`.
- 📍 **Auto Location Weather**: Show weather using IP-based location.
- 📊 **Chart Integration**: Display forecast data in graphical format (e.g., temperature trends).
- 📱 **Clean UI**: Built with GetX state management for responsive and organized architecture.

## 📂 Project Structure

- `lib/services/weather_service.dart`: Handles all API calls.
- `lib/models/`: Contains data models for weather, forecast, astronomy, etc.
- `lib/controllers/`: Business logic and state management using GetX.
- `lib/views/`: UI screens including home, forecast, and widgets like search bar and weather card.

## 🛠️ Getting Started

1. Clone the repo:
   ```bash
   git clone https://github.com/ayeshadastagir/weatherApp.git

