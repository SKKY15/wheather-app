class HourlyWeather {
  final DateTime time;
  final double temperature;
  final int weatherCode;
  final bool isDay;

  const HourlyWeather({
    required this.time,
    required this.temperature,
    required this.weatherCode,
    required this.isDay,
  });
}

class DailyWeather {
  final DateTime date;
  final double minTemp;
  final double maxTemp;
  final int weatherCode;


  const DailyWeather({
    required this.date,
    required this.minTemp,
    required this.maxTemp,
    required this.weatherCode
  });

}

class WeatherModel {
  final DateTime currentTime;
  final double currentTemperature;
  final int currentWeatherCode;
  final bool isDay;
  final double minimumTemperature;
  final double maximumTemperature;
  final List<HourlyWeather> hourly;
  final List<DailyWeather> daily;

  const WeatherModel({
    required this.currentTime,
    required this.currentTemperature,
    required this.currentWeatherCode,
    required this.isDay,
    required this.minimumTemperature,
    required this.maximumTemperature,
    required this.hourly,
    required this.daily
  });
}