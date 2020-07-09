import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:http/http.dart';
import 'package:weatherapi/fetchCity.dart';
import 'package:weatherapi/Displaying_weather.dart';

void main() {
  runApp(MaterialApp(
    home: weatherApp(),
    routes: {
      '\a':(context) => DisplayWeather()
    },
  ));
}

class weatherApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _weatherAppState createState() => _weatherAppState();
}

class _weatherAppState extends State<weatherApp> {
  final _formKey = GlobalKey<FormState>();
  final myControl = TextEditingController();
  String cityName;
  City cityWeather = City();
  String msg;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> setupcityWeather() async{
    City Citydata = City();
    msg = await Citydata.fetchCity(cityName);
    setState(() {
      cityWeather = City(weatherDescription:Citydata.weatherDescription , windSpeed:Citydata.windSpeed , temp:Citydata.temp , pressure: Citydata.pressure , percHumidity:Citydata.percHumidity);
      print(cityWeather.weatherDescription);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/weather.jpg'),
                  fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: TextFormField(
                                controller: myControl,
                                decoration: InputDecoration(
                                    hintText: "Enter a location"
                                ),
                                onChanged: (city){
                                  setState(() {
                                    cityName = city;
                                  });
                                },
                                validator: (value){
                                  if(value.isEmpty){
                                    return "Please enter a valid location";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                child: RaisedButton.icon(
                                  icon: Icon(
                                    Icons.wb_cloudy,
                                  ),
                                  label: Text("GET WEATHER"),
                                  onPressed: () async{
                                    if(_formKey.currentState.validate()){
                                        await setupcityWeather();
                                        SnackBar mysnackBar = SnackBar(content: Text(msg),duration: Duration(milliseconds: 250));
                                        if (msg != "Collecting data"){
                                          scaffoldKey.currentState.showSnackBar(mysnackBar);
                                        }else{
                                          scaffoldKey.currentState.showSnackBar(mysnackBar);
                                          Navigator.push(context, MaterialPageRoute(
                                            builder: (context) => DisplayWeather(cityweather: cityWeather,  cityName: cityName),
                                          ));
                                        }
                                    }
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)
                                  ),
                                ),
                              ),
                            )
                            ],
                          ),
                         ),
                      ),
                  ],
                ),
              ),
            )
          ],
        )
    );
  }
}
