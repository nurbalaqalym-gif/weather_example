import 'package:flutter/material.dart';
import 'package:weather_example/models/weather_forecast_daily.dart';

class TempView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecast> snapshot;

  const TempView({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    final forecastList = snapshot.data?.list ?? [];

    // Ауа райы туралы деректер болмаса, бос орын көрсетеміз.
    if (forecastList.isEmpty) {
      return const SizedBox.shrink();
    }

    final forecast = forecastList[0];

    // Белгіше, температура және сипаттаманы аламыз.
    final icon = forecast.getIconUrl();
    final temp = (forecast.temp?.day ?? 0).toStringAsFixed(0);

    final weatherList = forecast.weather ?? [];
    final description = weatherList.isNotEmpty
        ? (weatherList[0].description ?? 'Unknown').toUpperCase()
        : 'UNKNOWN';

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.network(
            icon,
            scale: 0.4,
            color: Colors.black87,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.cloud,
                size: 60,
                color: Colors.black87,
              );
            },
          ),
          const SizedBox(width: 20.0),
          Column(
            children: <Widget>[
              Text(
                '$temp °C',
                style: const TextStyle(
                  fontSize: 54.0,
                  color: Colors.black87,
                ),
              ),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
