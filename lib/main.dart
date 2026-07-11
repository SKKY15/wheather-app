import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/utils/weather_helper.dart';
import './models/card_item.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:flutter/foundation.dart';
import './models/weather_model.dart';
import './services/weather_service.dart';
import 'package:intl/intl.dart';
void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  
  @override
  State<MainApp> createState() => _MainAppState();

}

class _MainAppState extends State<MainApp> {

  final WeatherService _weatherService = WeatherService();
  //Geocoding? _geocoding;
  WeatherModel? _weather;
  String _locationName = 'Current location';
  String? _errorMessage;
  bool _isLoading = true;

  final days = [
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
    "Sun",
  ];

  @override
  void initState() {
    super.initState();
  //   if (_supportsNativeGeocoding) {
  //   _geocoding = Geocoding();
  // }
    _loadWeather();
  }
  
  @override
    Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration : BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF4DA8FF),
                Color(0xFF1E5AA8), // mid blue
                Color(0xFF071A3D),
              ])
          ),
          child: SafeArea(
            child : _buildBody()
          )
           )
      ),
    );
  }


  /*Future<Position> _determinePosition() async {
  final bool serviceEnabled =
      await Geolocator.isLocationServiceEnabled();

  if (!serviceEnabled) {
    throw Exception(
      'Location services are disabled. Please turn on GPS.',
    );
  }

  LocationPermission permission =
      await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }

  if (permission == LocationPermission.denied) {
    throw Exception('Location permission was denied.');
  }

  if (permission == LocationPermission.deniedForever) {
    throw Exception(
      'Location permission is permanently denied. '
      'Please enable it in your phone settings.',
    );
  }

  const locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
  );

  return Geolocator.getCurrentPosition(
    locationSettings: locationSettings,
  );
} */

/*Future<String> _getLocationName(Position position) async {
  try {
    final placemarks =
        await _geocoding?.placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isEmpty) {
      return 'Current location';
    }

    final place = placemarks.first;

    final parts = <String?>[
      place.locality,
      place.country,
    ]
        .whereType<String>()
        .where((part) => part.trim().isNotEmpty)
        .toList();

    if (parts.isEmpty) {
      return 'Current location';
    }

    return parts.join(', ');
  } catch (error) {
    return 'Current location';
  }
}*/
Future<void> _loadWeather() async {
  setState(() {
    _isLoading = true;
    _errorMessage = null;
  });

  try {
    const double latitude = 36.7579453;
    const double longitude = 3.4742128;
    final weather = await _weatherService.getWeather(
      latitude: latitude,
      longitude: longitude,
    );

    if (!mounted) return;

    setState(() {
      _weather = weather;
      _locationName = "Boumerdes, Algeria";
      _isLoading = false;
    });
  } catch (error) {
    if (!mounted) return;

    setState(() {
      _errorMessage = error.toString().replaceFirst(
            'Exception: ',
            '',
          );

      _isLoading = false;
    });
  }
}


String _formatDate(DateTime date) {
  const weekdays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  int hour = date.hour % 12;

  if (hour == 0) {
    hour = 12;
  }

  final minute = date.minute.toString().padLeft(2, '0');
  final period = date.hour < 12 ? 'AM' : 'PM';

  return '${weekdays[date.weekday - 1]}, '
      '${months[date.month - 1]} ${date.day} | '
      '$hour:$minute $period';
}

Widget _buildBody() {
  if (_isLoading) {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }

  if (_errorMessage != null) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.location_off,
              color: Colors.white,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              _errorMessage!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _loadWeather,
              icon: const Icon(Icons.refresh),
              label: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }

  return _buildWeatherContent();
}
Widget _buildWeatherContent() {
  final weather = _weather!;

  return RefreshIndicator(
    onRefresh: _loadWeather,
    child: SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),

          // Location name
          Text(
            _locationName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
            ),
          ),

          // Current date and time
          Text(
            _formatDate(weather.currentTime),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color.fromRGBO(232, 232, 232, 1),
              fontSize: 18,
            ),
          ),

          const SizedBox(height: 16),

          // Current weather card
          glassCard(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Current temperature
                      Text(
                        '${weather.currentTemperature.round()}°',
                        style: const TextStyle(
                          fontSize: 80,
                          color: Colors.white,
                        ),
                      ),

                      // Weather description
                      Text(
                        getWeatherDescription(
                          weather.currentWeatherCode,
                        ),
                        style: const TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                        ),
                      ),

                      // Minimum and maximum temperatures
                      Text(
                        '${weather.minimumTemperature.round()}° / '
                        '${weather.maximumTemperature.round()}°',
                        style: const TextStyle(
                          fontSize: 22,
                          color: Color.fromRGBO(
                            232,
                            232,
                            232,
                            1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                // Current weather icon
                SvgPicture.asset(
                  getWeatherIcon(
                    weather.currentWeatherCode,
                    isDay: weather.isDay,
                  ),
                  width: 130,
                  height: 130,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Hourly forecast card
          glassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hourly forecast',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),

                const SizedBox(height: 12),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: weather.hourly.map((hour) {
                      int displayHour = hour.time.hour % 12;

                      if (displayHour == 0) {
                        displayHour = 12;
                      }

                      return CardItem(
                        time: displayHour,
                        isAm: hour.time.hour < 12,
                        pic: getWeatherIcon(
                          hour.weatherCode,
                          isDay: hour.isDay,
                        ),
                        degree: hour.temperature.round(),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height : 8),
          glassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children : [
                Text("Daily forecast", style : TextStyle(
                  color : Colors.white,
                  fontSize: 24
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 2,
                      children: List.generate(_weather!.daily.length, (index) => Text(DateFormat('EEE').format(_weather!.daily[index].date), style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)))
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(_weather!.daily.length, (index) => Text(DateFormat('MMM d').format(_weather!.daily[index].date),  style: TextStyle(color: const Color.fromARGB(170, 255, 255, 255), fontSize: 18)))
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children : List.generate(_weather!.daily.length, (index) => SvgPicture.asset(getWeatherIcon(_weather!.daily[index].weatherCode, isDay: true), width: 32, height: 32))
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(_weather!.daily.length, (index) => Row(children: [
                        Text("${_weather!.daily[index].maxTemp}° / ", style : TextStyle(
                          color : Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize : 18
                        )),
                        Text("${_weather!.daily[index].minTemp}°", style : TextStyle(
                          color : const Color.fromARGB(170, 255, 255, 255),
                          fontSize : 18
                        ))
                      ],)),
                    ),
                  ],
                )
              ]
            )            
          ),


        ],
      ),
    ),
  );
}
// bool get _supportsNativeGeocoding {
//   if (kIsWeb) {
//     return false;
//   }

//   return defaultTargetPlatform == TargetPlatform.android ||
//       defaultTargetPlatform == TargetPlatform.iOS ||
//       defaultTargetPlatform == TargetPlatform.macOS;
// }
}




Widget glassCard({required Widget child}) {
  return ClipRRect(
    borderRadius: BorderRadiusGeometry.circular(16),
    child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20,sigmaY: 20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.25),
            width: 1.5,
            ),
          ),
          child: child
        ),
      
      ),
  );
} 