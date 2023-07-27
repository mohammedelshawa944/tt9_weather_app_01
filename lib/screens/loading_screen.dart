import 'package:flutter/material.dart';
import 'package:weather_app/screens/location_screen.dart';
import 'package:weather_app/services/location.dart';
import 'package:http/http.dart'as http;
import 'package:weather_app/utilities/constants.dart';


class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});



  @override
  LoadingScreenState createState() => LoadingScreenState();
}
class LoadingScreenState extends State<LoadingScreen> {

  void getCurrentLocation()  async {
   Location location = Location();
   location.getCurrentLocation();

   await getData(location.lat, location.long);

   // if(mounted){
   //   Navigator.push(context, MaterialPageRoute(builder: (context){
   //     return LocationScreen(position: location,);
   //   })
   //   );
   // }
  }


  Future<void> getData(double lat, double long)async {
    String url = 'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$kApiKey';
    // Response return body + statuscode
    http.Response response= await http.get(Uri.parse(url));

    print(response.statusCode);
    print(response.body);
  }


  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
