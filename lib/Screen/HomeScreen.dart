import 'package:flutter/material.dart';
import 'package:flutter_location_weather/Resources/Colors.dart';
import 'package:flutter_location_weather/Screen/Deivice_Location.dart';
import 'package:flutter_location_weather/Screen/Select_City_Location.dart';

class Home extends StatelessWidget {
  const Home({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    myColors Constrants = myColors();

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: Constrants.primaryColor.withOpacity(0.7),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('get-started.png'),
              const SizedBox(height: 30,),
              GestureDetector(
                   onTap: (){
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SelfLocation()));
                   },
                   child: Container(
                     height: 50,
                     width: size.width * 0.4,
                     decoration: BoxDecoration(
                       color: Constrants.primaryColor,
                       borderRadius: const BorderRadius.all(Radius.circular(10))
                     ),
                     child: const Center(
                       child: Text('Detect Your Weather', style: TextStyle(color: Colors.white, fontSize: 20),),
                     ),
                   ),
                 ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CityWeather()));
                },
                child: Container(
                  height: 50,
                  width: size.width * 0.4,
                  decoration: BoxDecoration(
                      color: Constrants.primaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10))
                  ),
                  child: const Center(
                    child: Text('Find City Weather', style: TextStyle(color: Colors.white, fontSize: 20),),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
