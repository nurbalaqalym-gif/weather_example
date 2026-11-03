import 'package:weather_example/utilities/constants.dart';

class WeatherForecast {
  City? city;
  String? cod;
  double? message;
  int? cnt;
  List<WeatherList>? list;

  WeatherForecast({this.city, this.cod, this.message, this.cnt, this.list});

  WeatherForecast.fromJson(Map<String, dynamic> json) {
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    cod = json['cod']?.toString();
    message = (json['message'] as num?)?.toDouble();
    cnt = json['cnt'];

    if (json['list'] != null) {
      list =
          (json['list'] as List).map((v) => WeatherList.fromJson(v)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (city != null) data['city'] = city!.toJson();
    data['cod'] = cod;
    data['message'] = message;
    data['cnt'] = cnt;
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class City {
  int? id;
  String? name;
  Coord? coord;
  String? country;
  int? population;
  int? timezone;

  City({
    this.id,
    this.name,
    this.coord,
    this.country,
    this.population,
    this.timezone,
  });

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    coord = json['coord'] != null ? Coord.fromJson(json['coord']) : null;
    country = json['country'];
    population = json['population'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    if (coord != null) data['coord'] = coord!.toJson();
    data['country'] = country;
    data['population'] = population;
    data['timezone'] = timezone;
    return data;
  }
}

class Coord {
  double? lon;
  double? lat;

  Coord({this.lon, this.lat});

  Coord.fromJson(Map<String, dynamic> json) {
    lon = (json['lon'] as num?)?.toDouble();
    lat = (json['lat'] as num?)?.toDouble();
  }

  Map<String, dynamic> toJson() => {
        'lon': lon,
        'lat': lat,
      };
}

class WeatherList {
  int? dt;
  int? sunrise;
  int? sunset;
  Temp? temp;
  FeelsLike? feelsLike;
  int? pressure;
  int? humidity;
  List<Weather>? weather;
  double? speed;
  int? deg;
  int? clouds;
  num? rain;

  WeatherList({
    this.dt,
    this.sunrise,
    this.sunset,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.weather,
    this.speed,
    this.deg,
    this.clouds,
    this.rain,
  });

  WeatherList.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    temp = json['temp'] != null ? Temp.fromJson(json['temp']) : null;
    feelsLike = json['feels_like'] != null
        ? FeelsLike.fromJson(json['feels_like'])
        : null;
    pressure = json['pressure'];
    humidity = json['humidity'];

    if (json['weather'] != null) {
      weather =
          (json['weather'] as List).map((v) => Weather.fromJson(v)).toList();
    }

    speed = (json['speed'] as num?)?.toDouble();
    deg = json['deg'];
    clouds = json['clouds'];
    rain = json['rain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['dt'] = dt;
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;
    if (temp != null) data['temp'] = temp!.toJson();
    if (feelsLike != null) data['feels_like'] = feelsLike!.toJson();
    data['pressure'] = pressure;
    data['humidity'] = humidity;
    if (weather != null) {
      data['weather'] = weather!.map((v) => v.toJson()).toList();
    }
    data['speed'] = speed;
    data['deg'] = deg;
    data['clouds'] = clouds;
    data['rain'] = rain;
    return data;
  }

  String getIconUrl() {
    final icon = weather?.isNotEmpty == true ? weather![0].icon : null;
    return '${Constants.WEATHER_IMAGES_URL}${icon ?? '01d'}.png';
  }
}

class Temp {
  double? day;
  double? min;
  double? max;
  double? night;
  double? eve;
  double? morn;

  Temp({this.day, this.min, this.max, this.night, this.eve, this.morn});

  Temp.fromJson(Map<String, dynamic> json) {
    day = (json['day'] as num?)?.toDouble();
    min = (json['min'] as num?)?.toDouble();
    max = (json['max'] as num?)?.toDouble();
    night = (json['night'] as num?)?.toDouble();
    eve = (json['eve'] as num?)?.toDouble();
    morn = (json['morn'] as num?)?.toDouble();
  }

  Map<String, dynamic> toJson() => {
        'day': day,
        'min': min,
        'max': max,
        'night': night,
        'eve': eve,
        'morn': morn,
      };
}

class FeelsLike {
  double? day;
  double? night;
  double? eve;
  double? morn;

  FeelsLike({this.day, this.night, this.eve, this.morn});

  FeelsLike.fromJson(Map<String, dynamic> json) {
    day = (json['day'] as num?)?.toDouble();
    night = (json['night'] as num?)?.toDouble();
    eve = (json['eve'] as num?)?.toDouble();
    morn = (json['morn'] as num?)?.toDouble();
  }

  Map<String, dynamic> toJson() => {
        'day': day,
        'night': night,
        'eve': eve,
        'morn': morn,
      };
}

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather({this.id, this.main, this.description, this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'main': main,
        'description': description,
        'icon': icon,
      };
}
