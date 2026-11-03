import 'package:flutter/material.dart';
import 'package:weather_example/models/weather_forecast_daily.dart';
import 'package:weather_example/utilities/forecast_util.dart';

class CityView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecast> snapshot;

  const CityView({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    final forecast = snapshot.data;
    final forecastList = forecast?.list ?? [];

    final city = forecast?.city?.name ?? 'Unknown city';
    final country = forecast?.city?.country ?? '';

    final formattedDate = forecastList.isNotEmpty && forecastList[0].dt != null
        ? DateTime.fromMillisecondsSinceEpoch(
            forecastList[0].dt! * 1000,
          )
        : DateTime.now();

    return Container(
      child: Column(
        children: <Widget>[
          Text(
            '$city, $country',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28.0,
              color: Colors.black87,
            ),
          ),
          Text(
            Util.getFormattedDate(formattedDate),
            style: const TextStyle(
              fontSize: 15.0,
            ),
          ),
        ],
      ),
    );
  }
}
