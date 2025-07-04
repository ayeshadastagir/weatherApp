class Astronomy {
  final String sunrise;
  final String sunset;
  final String moonrise;
  final String moonset;
  final String moonPhase;

  Astronomy({
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
  });

  factory Astronomy.fromJson(Map<String, dynamic> json) {
    return Astronomy(
      sunrise: json['astronomy']['astro']['sunrise'],
      sunset: json['astronomy']['astro']['sunset'],
      moonrise: json['astronomy']['astro']['moonrise'],
      moonset: json['astronomy']['astro']['moonset'],
      moonPhase: json['astronomy']['astro']['moon_phase'],
    );
  }
}