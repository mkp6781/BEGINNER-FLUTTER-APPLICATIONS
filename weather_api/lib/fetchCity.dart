import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class City {
  String weatherDescription;
  double windSpeed;
  double temp;
  int pressure;
  int percHumidity;
  String cityName;

  City({this.weatherDescription, this.windSpeed, this.temp, this.pressure, this.percHumidity , this.cityName});
//Example of returned JSON string: "weather":[{"id":701,"main":"Mist","description":"mist","icon":"50n"}],"base":"stations","main":{"temp":300.15,"feels_like":305.42,"temp_min":300.15,"temp_max":300.15,"pressure":1007,"humidity":88},"visibility":4500,"wind":{"speed":1.5,"deg":70}

  Future<String> fetchCity(String cityName) async {
    print("COLLECTING DATA");
    final res = await http.get('http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=0f6bc6e7080917e0766366b84da983f7');
    if (res.statusCode == 200) {
//json is in string format and cannot be read directly even though it looks like map
//json.decode converts it into map
      Map data = json.decode(res.body);
      weatherDescription =  data['weather'][0]['description'];
      windSpeed = data['wind']['speed'];
      temp = data['main']['temp'];
      pressure = data['main']['pressure'];
      percHumidity = data['main']['humidity'];
      String message = "Collecting data";
      return message;
    }
    else{
      Map data = json.decode(res.body);
      String message = data['message'];
      return message;
    }
  }
}