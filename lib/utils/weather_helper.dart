const Map<int, String> weatherDescription = {
  0: "Clear sky",
  1: "Mainly clear",
  2: "Partly cloudy",
  3: "Overcast",
  45: "Fog",
  48: "Depositing rime fog",
  51: "Light drizzle",
  53: "Moderate drizzle",
  55: "Dense drizzle",
  56: "Light freezing drizzle",
  57: "Dense freezing drizzle",
  61: "Slight rain",
  63: "Moderate rain",
  65: "Heavy rain",
  66: "Light freezing rain",
  67: "Heavy freezing rain",
  71: "Slight snow",
  73: "Moderate snow",
  75: "Heavy snow",
  77: "Snow grains",
  80: "Slight rain showers",
  81: "Moderate rain showers",
  82: "Violent rain showers",
  85: "Slight snow showers",
  86: "Heavy snow showers",
  95: "Thunderstorm",
  96: "Thunderstorm with slight hail",
  99: "Thunderstorm with heavy hail",
};

const Map<int, String> weatherIcons = {
  0: "assets/clear_day.svg",
  1: "assets/mostly_cloudy.svg",
  2: "assets/partly_cloudy.svg",
  3: "assets/cloudy.svg",

  45: "assets/fog_mist.svg",
  48: "assets/fog_mist.svg",

  51: "assets/drizzle.svg",
  53: "assets/drizzle.svg",
  55: "assets/drizzle.svg",
  56: "assets/sleet_mix.svg",
  57: "assets/sleet_mix.svg",

  61: "assets/light_rain.svg",
  63: "assets/rain.svg",
  65: "assets/heavy_rain.svg",
  66: "assets/sleet_mix.svg",
  67: "assets/sleet_mix.svg",

  71: "assets/snow.svg",
  73: "assets/snow.svg",
  75: "assets/snow.svg",
  77: "assets/snow.svg",

  80: "assets/rain_alt.svg",
  81: "assets/rain_alt.svg",
  82: "assets/heavy_rain.svg",

  85: "assets/snow.svg",
  86: "assets/snow.svg",

  95: "assets/thunderstorm.svg",
  96: "assets/thunderstorm_alt.svg",
  99: "assets/hail.svg",
};

String getWeatherDescription(int code) {
  return weatherDescription[code] ?? "Unknown weather";
}

String getWeatherIcon(int code, {required bool isDay}) {
  if (!isDay) {
    switch (code) {
      case 0:
        return 'assets/clear_night.svg';

      case 1:
      case 2:
      case 3:
        return 'assets/cloudy_night.svg';
    }
  }

  return weatherIcons[code] ?? "assets/cloudy.svg";
}