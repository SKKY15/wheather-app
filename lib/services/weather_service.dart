import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';


class WeatherService {
  Future<WeatherModel> getWeather({
      required double latitude,
      required double longitude
  }) async {
    final uri = Uri.https(
      'api.open-meteo.com',
      '/v1/forecast',
      {
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
        'current': 'temperature_2m,weather_code,is_day',
        'hourly': 'temperature_2m,weather_code,is_day',
        'daily': 'temperature_2m_min,temperature_2m_max',
        'timezone' : 'auto',
        'forecast_days' : '1',


      }
    );
    final response = await http.get(uri).timeout(
      const Duration(seconds: 15)
    );
    if(response.statusCode != 200) {
       throw Exception(
        'Could not load weather. Status: ${response.statusCode}',
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final currentJson = json['current'] as Map<String, dynamic>;
    final hourlyJson = json['hourly'] as Map<String, dynamic>;
    final dailyJson = json['daily'] as Map<String, dynamic>;


    final currentTime = DateTime.parse(
      currentJson['time'] as String
    );
    final hourlyTime = List<String>.from(
      hourlyJson['time'] as List
    );
    final hourlyTemperatures = List<num>.from(
      hourlyJson['temperature_2m'] as List
    );
    final hourlyCodes = List<num>.from(
      hourlyJson['weather_code'] as List
    );
     final hourlyIsDay = List<num>.from(
      hourlyJson['is_day'] as List,
    );

    final currentHour = DateTime(
      currentTime.year,
      currentTime.month,
      currentTime.day,
      currentTime.hour,
    );

    final hourlyWeather = <HourlyWeather>[];

    
    for (int index = 0; index < hourlyTime.length; index++) {
      final time = DateTime.parse(hourlyTime[index]);

      if (time.isBefore(currentHour)) {
        continue;
      }

      hourlyWeather.add(
        HourlyWeather(
          time: time,
          temperature: hourlyTemperatures[index].toDouble(),
          weatherCode: hourlyCodes[index].toInt(),
          isDay: hourlyIsDay[index].toInt() == 1,
        ),
      );
      if (hourlyWeather.length == 24) {
        break;
      }
    }
    final minimumTemperatures = List<num>.from(
      dailyJson['temperature_2m_min'] as List,
    );

    final maximumTemperatures = List<num>.from(
      dailyJson['temperature_2m_max'] as List,
    );

    return WeatherModel(
      currentTime: currentTime,
      currentTemperature: (currentJson['temperature_2m'] as num).toDouble(),
      currentWeatherCode: (currentJson["weather_code"] as num).toInt(),
      isDay: (currentJson['is_day'] as num).toInt() == 1, 
      minimumTemperature: minimumTemperatures.first.toDouble(), 
      maximumTemperature: maximumTemperatures.first.toDouble(), 
      hourly: hourlyWeather
      );

  }
}