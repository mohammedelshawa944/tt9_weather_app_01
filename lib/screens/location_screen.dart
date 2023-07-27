import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/screens/city_screen.dart';
import 'package:weather_app/services/weather_model.dart';
import '../utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  final WeatherModel weatherData;
  const LocationScreen({super.key, required this.weatherData});

  @override
  LocationScreenState createState() => LocationScreenState();
}

class LocationScreenState extends State<LocationScreen> {

  bool isLoaded =false;
  final ImageProvider _image = const AssetImage('images/location_background.jpg');
  final ImageProvider _networkImage = const NetworkImage('https://source.unsplash.com/random/?nature,day');

  void getImageProvider(){
    _networkImage
        .resolve(ImageConfiguration())
        .addListener(ImageStreamListener((image, synchronousCall) {
          setState(() {
            isLoaded = true;
          });
    }));
  }



  late int temp;
  late String cityName;
  late String icon;
  late String description;
  @override

  void upDateUi(){
    temp = widget.weatherData.temp.toInt();
    cityName = widget.weatherData.name;
    icon = widget.weatherData.getWeatherIcon();
    description = widget.weatherData.getMessage();
  }

  void initState() {
    upDateUi();
    getImageProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                // image: AssetImage('images/location_background.jpg'),
                image: !isLoaded ? _image : _networkImage,
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.8), BlendMode.dstATop),
              ),
            ),
            constraints: const BoxConstraints.expand(),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.white.withOpacity(0.5),
                    Colors.white.withOpacity(0.5)
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  // color: Colors.white.withOpacity(0.0),
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder:(context) => CityScreen()));
                      },
                      child: const Icon(
                        Icons.near_me,
                        size: 34.0,
                        color: kSecondaryColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Icon(
                        Icons.location_city,
                        size: 34.0,
                        color: kSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 100,),
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('$icon',style: TextStyle(
                      fontSize: 80
                    ),),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '$temp',
                          style: kTempTextStyle,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.white, width: 10),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 7,
                              width: 35,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                                // shape: BoxShape.circle,
                              ),
                            ),
                            const Text(
                              'now',
                              style: TextStyle(
                                fontSize: 30.0,
                                fontFamily: 'Spartan MB',
                                letterSpacing: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 100,),
              Padding(
                padding: EdgeInsets.only(right: 24.0),
                child: Text(
                  '$description',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
              // ClipRRect(
              //   child: BackdropFilter(
              //     filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              //     child: Container(
              //       padding: EdgeInsets.all(34),
              //       decoration: BoxDecoration(
              //         color: Colors.white.withOpacity(0.1),
              //       ),
              //       child: Text('Weather'),
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}