class Weather {
  final String city;
  final String region;
  final String country;
  final double tempC;
  final double tempF;
  final String condition;
  final String iconUrl;
  final double humidity;
  final double windKph;
  final double windMph;
  final String windDir;
  final double pressureMb;
  final double visibilityKm;
  final double uvIndex;
  final double feelsLikeC;
  final String localTime;
  final String timezone;

  Weather({
    required this.city,
    required this.region,
    required this.country,
    required this.tempC,
    required this.tempF,
    required this.condition,
    required this.iconUrl,
    required this.humidity,
    required this.windKph,
    required this.windMph,
    required this.windDir,
    required this.pressureMb,
    required this.visibilityKm,
    required this.uvIndex,
    required this.feelsLikeC,
    required this.localTime,
    required this.timezone,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      city: json['location']['name'],
      region: json['location']['region'],
      country: json['location']['country'],
      tempC: json['current']['temp_c'].toDouble(),
      tempF: json['current']['temp_f'].toDouble(),
      condition: json['current']['condition']['text'],
      iconUrl: 'https:${json['current']['condition']['icon']}',
      humidity: json['current']['humidity'].toDouble(),
      windKph: json['current']['wind_kph'].toDouble(),
      windMph: json['current']['wind_mph'].toDouble(),
      windDir: json['current']['wind_dir'],
      pressureMb: json['current']['pressure_mb'].toDouble(),
      visibilityKm: json['current']['vis_km'].toDouble(),
      uvIndex: json['current']['uv'].toDouble(),
      feelsLikeC: json['current']['feelslike_c'].toDouble(),
      localTime: json['location']['localtime'],
      timezone: json['location']['tz_id'],
    );
  }
}