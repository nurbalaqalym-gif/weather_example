import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_example/models/weather_forecast_daily.dart';
import 'package:weather_example/utilities/forecast_util.dart';

class DetailView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecast> snapshot;

  const DetailView({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    final forecastList = snapshot.data?.list ?? [];

    // Егер ауа райы деректері жоқ болса, бос орын көрсетеміз.
    if (forecastList.isEmpty) {
      return const SizedBox.shrink();
    }

    final forecast = forecastList[0];

    // Қысымды hPa-дан mm Hg-ға айналдырамыз.
    final pressure = (forecast.pressure ?? 0) * 0.750062;
    final humidity = forecast.humidity ?? 0;
    final wind = forecast.speed ?? 0.0;

    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Util.getItem(
            FontAwesomeIcons.thermometerThreeQuarters,
            pressure.round(),
            'mm Hg',
          ),
          Util.getItem(
            FontAwesomeIcons.cloudRain,
            humidity,
            '%',
          ),
          Util.getItem(
            FontAwesomeIcons.wind,
            wind.toInt(),
            'm/s',
          ),
        ],
      ),
    );
  }
}
