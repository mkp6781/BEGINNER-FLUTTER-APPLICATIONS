import 'dart:convert';
import 'package:http/http.dart' as http;

class City{
  final String weatherDescription;
  final double windSpeed;
  final double temp;
  final int pressure;
  final int percHumidity;

  City({this.weatherDescription, this.windSpeed, this.temp, this.pressure, this.percHumidity});
//  "weather":[{"id":701,"main":"Mist","description":"mist","icon":"50n"}],"base":"stations","main":{"temp":300.15,"feels_like":305.42,"temp_min":300.15,"temp_max":300.15,"pressure":1007,"humidity":88},"visibility":4500,"wind":{"speed":1.5,"deg":70}
  factory City.fromJson(Map<String,dynamic> json){
    return City(
      weatherDescription : json['weather'][0]['description'],
      windSpeed : json['wind']['speed'],
      temp : json['main']['temp'],
      pressure : json['main']['pressure'],
      percHumidity : json['main']['humidity']
    );
  }
}