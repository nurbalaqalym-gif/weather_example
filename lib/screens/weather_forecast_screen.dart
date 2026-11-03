import 'package:weather_example/api/weather_api.dart';
import 'package:weather_example/models/weather_forecast_daily.dart';
import 'package:weather_example/screens/city_screen.dart';
import 'package:weather_example/widgets/bottom_list_view.dart';
import 'package:weather_example/widgets/city_view.dart';
import 'package:weather_example/widgets/detail_view.dart';
import 'package:weather_example/widgets/temp_view.dart';
import 'package:flutter/material.dart';

class WeatherForecastScreen extends StatefulWidget {
  final WeatherForecast? locationWeather;

  const WeatherForecastScreen({super.key, this.locationWeather});

  @override
  State<WeatherForecastScreen> createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  late Future<WeatherForecast> forecastObject;
  String _cityName = '';

  @override
  void initState() {
    super.initState();

    // Егер бастапқы ауа райы берілсе, соны көрсетеміз.
    if (widget.locationWeather != null) {
      forecastObject = Future.value(widget.locationWeather!);
    } else {
      // Бастапқыда телефонның орналасқан жеріндегі ауа райын аламыз.
      forecastObject = WeatherApi().fetchWeatherForecast(
        city: '',
        isCity: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text('Weather forecast'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.my_location),
          onPressed: () {
            setState(() {
              // Қайтадан қазіргі орналасқан жердің ауа райын аламыз.
              forecastObject = WeatherApi().fetchWeatherForecast(
                city: '',
                isCity: false,
              );
            });
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.location_city),
            onPressed: () async {
              final tappedName = await Navigator.push<String>(
                context,
                MaterialPageRoute(
                  builder: (context) => CityScreen(),
                ),
              );

              if (tappedName != null && tappedName.trim().isNotEmpty) {
                setState(() {
                  _cityName = tappedName.trim();

                  // Енгізілген қаланың ауа райын аламыз.
                  forecastObject = WeatherApi().fetchWeatherForecast(
                    city: _cityName,
                    isCity: true,
                  );
                });
              }
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          FutureBuilder<WeatherForecast>(
            future: forecastObject,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (snapshot.hasData) {
                return Column(
                  children: <Widget>[
                    const SizedBox(height: 50.0),
                    CityView(snapshot: snapshot),
                    const SizedBox(height: 50.0),
                    TempView(snapshot: snapshot),
                    const SizedBox(height: 50.0),
                    DetailView(snapshot: snapshot),
                    const SizedBox(height: 50.0),
                    BottomListView(snapshot: snapshot),
                  ],
                );
              }

              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Text(
                    'City not found\nPlease, enter correct city',
                    style: TextStyle(fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
