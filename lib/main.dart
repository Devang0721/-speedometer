import 'package:flutter/material.dart';
import 'authenticate.dart';
import 'helperfunction.dart';
import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool status = false;

  @override
  void initState() {
    getStatus();
    super.initState();
  }

  getStatus()async{
    await HelperFunction.getUserLoggedInSharedPreference().then((val){
      setState(() {
        status = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AcciAlert',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor : Colors.deepOrangeAccent,
      ),
      home: status != null ?  status ? Home() : Authenticate(): Authenticate(),
    );
  }
}


 