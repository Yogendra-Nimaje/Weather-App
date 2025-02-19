import 'package:flutter/material.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              "Minsk",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ))
        ],
      ),
      body: Column(
        children: [
          const Center(child: InfoCard()),
          Image.asset(
            'assets/thunder.png',
            height: 250,
          ),
          const Text(
            "23°",
            style: TextStyle(
                fontSize: 80, color: Colors.white, fontWeight: FontWeight.w600),
          ),
          const Text(
            "Thunder Clouds",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          const SizedBox(height: 20),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: WeatherInfoCard()),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Today',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      '7 Days',
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 100,
            child: ListView.separated(
                padding: const EdgeInsets.only(left: 24),
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: ((context, index) =>
                    TodayWeatherCard(weather: todayWeather[index])),
                separatorBuilder: ((context, index) =>
                const SizedBox(width: 10)),
                itemCount: todayWeather.length),
          )
        ],
      ),
    );
  }
}

class WeatherInfoCard extends StatelessWidget {
  const WeatherInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white.withOpacity(0.1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            children: [
              Icon(
                Icons.wind_power_outlined,
                color: Colors.grey,
              ),
              SizedBox(height: 5),
              Text(
                "35 km/h",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                "Wind",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              )
            ],
          ),
          Container(
            height: 30,
            width: 2,
            color: Colors.grey,
          ),
          const Column(
            children: [
              Icon(
                Icons.water_drop,
                color: Colors.blue,
              ),
              SizedBox(height: 5),
              Text(
                "24 %",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                "Humidity",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              )
            ],
          ),
          Container(
            height: 30,
            width: 2,
            color: Colors.grey,
          ),
          const Column(
            children: [
              Icon(
                Icons.water,
                color: Colors.grey,
              ),
              SizedBox(height: 5),
              Text(
                "83%",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                "Rain",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class TodayWeatherCard extends StatelessWidget {
  final TodayModel weather;
  const TodayWeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 75,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Text(
            "{weather.temperature}°",
            style: const TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
          ),
          Image.asset('assets/thunder.png', height: 40),
          Text(
            weather.time,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.yellow)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 5,
            width: 5,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.yellow),
          ),
          const SizedBox(width: 6),
          const Text(
            "Upcoming",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}

class TodayModel {
  String temperature;
  String time;
  TodayModel({
    required this.temperature,
    required this.time,
  });
}

List<TodayModel> todayWeather = [
  TodayModel(temperature: '23', time: '9:00 am'),
  TodayModel(temperature: '20', time: '10:00 am'),
  TodayModel(temperature: '19', time: '11:00 am'),
  TodayModel(temperature: '25', time: '12:00 pm'),
  TodayModel(temperature: '29', time: '1:00 am'),
];
