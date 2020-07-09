import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weatherapi/fetchCity.dart';

class DisplayWeather extends StatefulWidget {
  City cityweather;
  String cityName;
  DisplayWeather({this.cityweather , this.cityName });

  @override
  _DisplayWeatherState createState() => _DisplayWeatherState();
}

class _DisplayWeatherState extends State<DisplayWeather> with SingleTickerProviderStateMixin{

  Animation animation,delayedAnimation , muchDelayedAnimation;
  AnimationController animationController;

  List<String> iconPath = [
    'assets/humidity.png',
    'assets/pressure.png',
    'assets/temp.png'
    'assets/wind.png'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = Tween(begin: -1.0, end: 0).animate(CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      parent: animationController
    ));

    delayedAnimation = Tween(begin:-0.5, end: 0).animate(CurvedAnimation(
        curve: Interval(0.5 , 1 ,curve: Curves.fastOutSlowIn),
        parent: animationController
    ));

    muchDelayedAnimation = Tween(begin: -1.0, end: 0).animate(CurvedAnimation(
        curve: Interval(0.75 , 1 ,curve: Curves.fastOutSlowIn),
        parent: animationController
    ));
  }

  @override
  Widget build(BuildContext context) {
    String disp = 'assets/storm.jpg';
    final double width = MediaQuery.of(context).size.width;
    animationController.forward();
    switch (widget.cityweather.weatherDescription){
      case "overcast clouds":
        disp = 'assets/overcast_clouds.jpg';
        break;
      case "haze":
        disp = 'assets/haze.jpg';
        break;
      case "broken clouds"  "scattered ":
        disp = 'assets/broken.jpg';
        break;
      case "scattered clouds":
        disp = 'assets/overcast_clouds.jpg';
        break;
    }
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context,Widget child){
      return Scaffold(
//      backgroundColor: Colors.grey[700],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
          onPressed: (){
              Navigator.pop(context);
          },),
          title: Text(widget.cityName,
            style: TextStyle(
              color: Colors.black,
                  fontSize: 25,
                fontWeight: FontWeight.bold
            ),),

        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8 , 0 , 8 , 0 ),
            child: Column(
                        children: <Widget>[
                              Transform(
                                transform: Matrix4.translationValues(animation.value *width, 0.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image: AssetImage(disp),
                                      fit: BoxFit.cover
                                    )
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(widget.cityweather.weatherDescription.toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30,
                                      ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 5,),
                              Expanded(
                                child: Transform(
                                  transform: Matrix4.translationValues( 0,delayedAnimation.value *width, 0),
                                  child: GridView.count(
//                                shrinkWrap: true,
                                    crossAxisCount: 2,
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8,
                                    children: <Widget>[
                                       Container(
                                          height: 40,
                                          decoration: BoxDecoration(
//                                        color: Colors.transparent,
                                            gradient: LinearGradient(
                                              begin: Alignment.bottomLeft,
                                              end: Alignment.topRight,
                                              colors: [
                                                Colors.amber.withOpacity(1),
                                                Colors.amber.withOpacity(.2)
                                              ]
                                            ),
                                            borderRadius: BorderRadius.circular(30),
                                            image: DecorationImage(
                                              alignment: Alignment(0 ,-1),
                                              image: AssetImage('assets/temp.png'),
                                              )
                                            ),
                                         child: Padding(
                                           padding: const EdgeInsets.fromLTRB(0 , 30 ,0 ,0),
                                           child: Center(
                                             child: Text("${widget.cityweather.temp.toString()}K",
                                               style: TextStyle(
                                                 fontSize: 36
                                                 ),),
                                           ),
                                         ),
                                          ),
                                      Container(
                                        height: 40,
                                        decoration: BoxDecoration(
//                                        color: Colors.transparent,
                                            gradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  Colors.amber.withOpacity(.2),
                                                  Colors.amber.withOpacity(1)
                                                ]
                                            ),
                                            borderRadius: BorderRadius.circular(30),
                                            image: DecorationImage(
                                              alignment: Alignment(0 ,-.8),
                                              image: AssetImage('assets/pressure.png'),
                                            )
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0 , 30 ,0 ,0),
                                          child: Center(
                                            child: Text("${widget.cityweather.pressure.toString()} hPa",
                                              style: TextStyle(
                                                  fontSize: 36
                                              ),),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 40,
                                        decoration: BoxDecoration(
//                                        color: Colors.transparent,
                                            gradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  Colors.amber.withOpacity(1),
                                                  Colors.amber.withOpacity(.2)
                                                ]
                                            ),
                                            borderRadius: BorderRadius.circular(30),
                                            image: DecorationImage(
                                              alignment: Alignment(0 ,-.8),
                                              image: AssetImage('assets/humidity.png'),
                                            )
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0 , 30 ,0 ,0),
                                          child: Center(
                                            child: Text("${widget.cityweather.percHumidity.toString()}%",
                                              style: TextStyle(
                                                  fontSize: 36
                                              ),),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(

                                            gradient: LinearGradient(
                                                begin: Alignment.topRight,
                                                end: Alignment.bottomLeft,
                                                colors: [
                                                  Colors.amber.withOpacity(1),
                                                  Colors.amber.withOpacity(.2)
                                                ]
                                            ),
                                            borderRadius: BorderRadius.circular(30),
                                            image: DecorationImage(
                                              alignment: Alignment(0 ,-.8),
                                              image: AssetImage('assets/wind.png'),
                                            )
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0 , 30 ,0 ,0),
                                          child: Center(
                                            child: Text("${widget.cityweather.windSpeed.toString()} m/s",
                                              style: TextStyle(
                                                  fontSize: 36
                                              ),),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        ],
            ),
          ),
        )
      );
      },
    );
  }
}

