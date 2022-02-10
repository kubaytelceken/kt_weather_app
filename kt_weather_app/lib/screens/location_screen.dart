import 'package:flutter/material.dart';
import 'package:kt_weather_app/services/weather.dart';
import 'package:kt_weather_app/utilities/constants.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;
  LocationScreen({this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();

  int temperature = 0;
  String condition = "";
  String cityname = "";
  String conditionImage = "";
  String conditionIconImage = "";
  String saat = "";
  String formattedDate = DateFormat('hh:MM').format(DateTime.now());
  late DateFormat timeFormat;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeDateFormatting();

    var timeFormat = new DateFormat.Hms('tr');

    print("Yeni Sayfa");
    print(widget.locationWeather);
    UpdateUI(widget.locationWeather);
  }

  void UpdateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        conditionImage = 'bulutlu.jpg';
        condition = 'ALINAMADI.';
        cityname = 'Alınamadı';
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      condition = weatherData['weather'][0]['main'];
      conditionImage = weatherModel.getWeatherImage(condition);
      conditionIconImage = weatherModel.getWeatherIconImage(condition);
      condition = weatherModel.getWeatherName(condition);
      cityname = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm').format(now);
    String gun = DateFormat('EEEE').format(now);
    String gunValue = weatherModel.getDay(gun);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/$conditionImage'),
            fit: BoxFit.fill,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weatherModel.getLocationWeather();
                      UpdateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 40.0,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (typedName != null) {
                        var weatherData =
                            await weatherModel.getCityWeather(typedName);
                        UpdateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 40.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 40.0,
                  ),
                  Column(
                    children: [
                      Text(
                        gunValue,
                        style: kDayTextStyle,
                      ),
                      Text(
                        formattedDate,
                        style: kDegreeTextStyle,
                      )
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Align(
                    child:
                        Image.asset("images/$conditionIconImage", height: 250),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Column(
                    children: [
                      Text(
                        condition,
                        style: kWeatherTextStyle,
                      ),
                      Text(
                        "$temperature °C",
                        style: kDegreeTextStyle,
                      )
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    size: 40.0,
                    color: Colors.white,
                  ),
                  Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        cityname,
                        style: kDayTextStyle,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
