import 'package:flutter/material.dart';
import '../service/weather_api.dart';
import '../models/weather_model.dart';
import 'detail_screen.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  late Future<List<Weather>> futureWeather;

  @override
  void initState() {
    super.initState();
    futureWeather = WeatherAPI.fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              color: Colors.white,
            ),
            Text(
              "Surat",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<List<Weather>>(
              future: futureWeather,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else {
                  List<Weather> weatherList = snapshot.data!;
                  var todayWeather = weatherList.take(8).toList();
                  var nextDaysWeather = weatherList.skip(8).take(5).toList();

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        // Main Weather Display
                        Image.asset(
                          getWeatherIcon(todayWeather[0].temp),
                          height: 250,
                        ),
                        Text(
                          "${todayWeather[0].temp.toDouble().toStringAsFixed(1)}°",
                          style: const TextStyle(
                            fontSize: 80,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          todayWeather[0].description,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),


                        const Text(
                          "Today's Forecast",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 100,
                          child: ListView.separated(
                            padding: const EdgeInsets.only(left: 24),
                            shrinkWrap: true, // Allows ListView to fit its content
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      weather: todayWeather[index],
                                    ),
                                  ),
                                );
                              },
                              child: WeatherInfoCard(weather: todayWeather[index]),
                            ),
                            separatorBuilder: (context, index) => const SizedBox(width: 10),
                            itemCount: todayWeather.length,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Next Days Forecast",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 150,
                          child: ListView.builder(
                            padding: const EdgeInsets.only(left: 24, right: 24),
                            physics: const NeverScrollableScrollPhysics(), // Prevent nested scrolling
                            shrinkWrap: true, // Allows ListView to fit its content
                            itemCount: nextDaysWeather.length,
                            itemBuilder: (context, index) {
                              var weather = nextDaysWeather[index];
                              return Card(
                                color: Colors.white.withOpacity(0.1),
                                margin: const EdgeInsets.only(bottom: 10),
                                child: ListTile(
                                  leading: Image.asset(
                                    getWeatherIcon(weather.temp),
                                    height: 80,
                                  ),
                                  title: Text(
                                    weather.description,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  subtitle: Text(
                                    "Min: ${weather.minTemp.toStringAsFixed(1)}°C, Max: ${weather.maxTemp.toStringAsFixed(1)}°C",
                                    style: const TextStyle(color: Colors.white70),
                                  ),
                                  trailing: Text(
                                    "${weather.temp.toStringAsFixed(1)}°C",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
        ),
        ),
    );
  }
}

// Function moved outside to be used anywhere
String getWeatherIcon(double temp) {
  if (temp <= 10) {
    return "assets/rainy.png";
  } else if (temp > 10 && temp <= 20) {
    return "assets/thunder.png";
  } else if (temp > 20 && temp <= 28) {
    return "assets/cloudy.png";
  } else {
    return "assets/cloudy.png";
  }
}

class WeatherInfoCard extends StatelessWidget {
  final Weather weather;
  const WeatherInfoCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withOpacity(0.1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.asset(
              getWeatherIcon(weather.temp),
              height: 40,
            ),
            Text(
              "${weather.temp.toDouble().toStringAsFixed(1)}°",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              weather.description,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
