import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherAPI {
  static Future<List<Weather>> fetchWeather() async {
    const String apiKey = "eaa5cb486e4834c23fd7425026c972f8";
    const String city = "Surat,in";
    const String url = "https://api.openweathermap.org/data/2.5/forecast?q=$city&units=metric&appid=$apiKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> list = data['list'];
      return list.map((json) => Weather.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
