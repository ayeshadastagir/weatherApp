class ForecastDay {
  final String date;
  final double maxTempC;
  final double minTempC;
  final String condition;
  final String iconUrl;
  final double avgTempC;
  final double chanceOfRain;
  final double maxWindKph;
  final double avgHumidity;

  ForecastDay({
    required this.date,
    required this.maxTempC,
    required this.minTempC,
    required this.condition,
    required this.iconUrl,
    required this.avgTempC,
    required this.chanceOfRain,
    required this.maxWindKph,
    required this.avgHumidity,
  });

  factory ForecastDay.fromJson(Map<String, dynamic> json) {
    return ForecastDay(
      date: json['date'],
      maxTempC: json['day']['maxtemp_c'].toDouble(),
      minTempC: json['day']['mintemp_c'].toDouble(),
      condition: json['day']['condition']['text'],
      iconUrl: 'https:${json['day']['condition']['icon']}',
      avgTempC: json['day']['avgtemp_c'].toDouble(),
      chanceOfRain: json['day']['daily_chance_of_rain'].toDouble(),
      maxWindKph: json['day']['maxwind_kph'].toDouble(),
      avgHumidity: json['day']['avghumidity'].toDouble(),
    );
  }
}