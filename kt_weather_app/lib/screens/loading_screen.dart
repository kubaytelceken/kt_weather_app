import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kt_weather_app/services/location.dart';

import 'package:http/http.dart' as http;
import 'package:kt_weather_app/services/networking.dart';
import 'package:kt_weather_app/services/weather.dart';

import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  dynamic weatherData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationData();
  }

  late double latitude;
  late double longitude;
  void getLocationData() async {
    WeatherModel weatherModel = WeatherModel();
    weatherData = await weatherModel.getLocationWeather();
    print("DENENENNENE");
    print(weatherData);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: SpinKitFadingCube(
        color: Colors.blueAccent,
        size: 100.0,
      )),
    );
  }
}
