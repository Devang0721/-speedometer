import 'dart:math';
import 'package:accialert/popup.dart';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'package:accialert/widget.dart';
import 'speedometer.dart';

class SpeedometerContainer extends StatefulWidget {
  @override
  _SpeedometerContainerState createState() => _SpeedometerContainerState();
}

class _SpeedometerContainerState extends State<SpeedometerContainer> {
  double velocity = 0;
  double highestVelocity = 0.0;

  @override
  void initState() {
    userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      _onAccelerate(event);
    });
    super.initState();
  }

  void _onAccelerate(UserAccelerometerEvent event) {
    double newVelocity = sqrt(
        event.x * event.x + event.y * event.y + event.z * event.z
    );

    if ((newVelocity - velocity).abs() < 1) {
      return;
    }
    if((newVelocity - velocity).abs() >= 3){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Popup()));
      setState(() {});
    }
    setState(() {
      velocity = newVelocity;

      if (velocity > highestVelocity) {
        highestVelocity = velocity;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AccialertAppLog(context),
      body: Stack(
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.symmetric(vertical: 50,horizontal: 20),
            child: GestureDetector(
              onTap: (){
                Navigator.pop(context);
    },
              child: Container(
                alignment: Alignment.center,
                height: 60,
                width: MediaQuery.of(context).size.width / 2,
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      const Color(0xffffAb91),
                      const Color(0xffff5722)
                    ]),
                    borderRadius: BorderRadius.circular(30)),
                child: Text('Exit',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500)),
              ),
            ),
          ),
          Center(
            child: Speedometer(
              speed: velocity,
              speedRecord: highestVelocity,
            )
          )
        ]
      )
    );
  }
}