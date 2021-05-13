import 'package:accialert/speedometer_container.dart';
import 'package:accialert/widget.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AccialertAppLog(context),
      body: Center(
        child: GestureDetector(
          onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> SpeedometerContainer())),
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
            child: Text('Start Driving..',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500)),
          ),
        )
      ),
    );
  }
}

