import 'package:kt_weather_app/services/location.dart';
import 'package:kt_weather_app/services/networking.dart';

const apiKey = '21259ff2b7e13dc6a029ff7d8c40e410';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');
    print('$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    print("KOnya");
    print(weatherData);
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    print(weatherData);
    return weatherData;
  }

  String getWeatherName(String condition) {
    if (condition == "Rain") {
      return "YAĞMURLU";
    } else if (condition == "Clouds") {
      return "BULUTLU";
    } else if (condition == "Snow") {
      return "KARLI";
    } else if (condition == "Clear") {
      return "AÇIK";
    } else if (condition == "Thunderstorm") {
      return "GÖK GÜRÜLTÜLÜ";
    } else {
      return "PARÇALI BULUTLU";
    }
  }

  String getWeatherImage(String condition) {
    if (condition == "Rain") {
      return "yagmurlu.jpg";
    } else if (condition == "Clouds") {
      return "bulutlu.jpg";
    } else if (condition == "Snow") {
      return "karli.jpg";
    } else if (condition == "Clear") {
      return "gunesli.jpg";
    } else if (condition == "Thunderstorm") {
      return "gokgurultulu.jpg";
    } else {
      return "azbulut.jpg";
    }
  }

  String getWeatherIconImage(String condition) {
    if (condition == "Rain") {
      return "rainy-day.png";
    } else if (condition == "Clouds") {
      return "cloud-computing.png";
    } else if (condition == "Snow") {
      return "frozen.png";
    } else if (condition == "Clear") {
      return "sunny.png";
    } else if (condition == "Thunderstorm") {
      return "storm.png";
    } else {
      return "clear-sky.png";
    }
  }

  String getDay(String day) {
    if (day == "Monday") {
      return "Pazartesi";
    } else if (day == "Tuesday") {
      return "Salı";
    } else if (day == "Wednesday") {
      return "Çarşamba";
    } else if (day == "Thursday") {
      return "Perşembe";
    } else if (day == "Friday") {
      return "Cuma";
    } else if (day == "Saturday") {
      return "Cumartesi";
    } else {
      return "Pazar";
    }
  }
}
