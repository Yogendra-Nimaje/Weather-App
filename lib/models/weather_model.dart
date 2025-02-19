class Weather {
  final String description;
  final double temp;
  final String icon;
  final double windSpeed;
  final int humidity;
  final double rainChance;
  final double minTemp;
  final double maxTemp;

  Weather({
    required this.description,
    required this.temp,
    required this.icon,
    required this.windSpeed,
    required this.humidity,
    required this.rainChance,
    required this.minTemp,
    required this.maxTemp,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      description: json['weather'][0]['description'],
      temp: (json['main']['temp'] as num).toDouble(),
      icon: json['weather'][0]['icon'],
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      humidity: json['main']['humidity'],
      rainChance: (json['pop'] != null ? (json['pop'] as num) * 100 : 0).toDouble(),
      minTemp: (json['main']['temp_min'] as num).toDouble(),
      maxTemp: (json['main']['temp_max'] as num).toDouble(),
    );
  }
}
