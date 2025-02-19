import 'package:flutter/material.dart';
import '../models/weather_model.dart';

class DetailScreen extends StatelessWidget {
  final Weather weather;
  const DetailScreen({super.key, required this.weather});

  // Method to get icon based on temperature
  String _getWeatherIcon(double temp) {
    if (temp <= 10) {
      return "assets/rainy.png";
    }else if(temp > 10 && temp <=20){
      return "assets/thunder.png";
    }
    else if (temp > 20 && temp <= 28) {
      return "assets/cold.png";
    } else {
      return "assets/cloudy.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              _getWeatherIcon(weather.temp),
              height: 150,
            ),
            const SizedBox(height: 20),
            Text(
              "${weather.temp.toStringAsFixed(1)}°C",
              style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            Text(
              weather.description,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Text(
              "Min: ${weather.minTemp.toStringAsFixed(1)}°C, Max: ${weather.maxTemp.toStringAsFixed(1)}°C",
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
