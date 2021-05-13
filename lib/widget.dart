import 'package:flutter/material.dart';

import 'authenticate.dart';
import 'helperfunction.dart';

Widget AccialertApp(context){
  return AppBar(
    flexibleSpace: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                const Color(0xffff8A65),
                const Color(0xffff5722)
              ])),
    ),
    title: Text('Accialert'),
    actions: [
      IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.person,
          color: Colors.white,
        ),
      ),
    ],
  );
}

Widget AccialertAppLog(context) {
  return AppBar(
    flexibleSpace: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                const Color(0xffff8A65),
                const Color(0xffff5722)
              ])),
    ),
    title: Text('Accialert'),
    actions: [
      IconButton(
        onPressed: () {
          HelperFunction.saveUserLoggedInSharedPreference(false);

          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => Authenticate()
          ));
        },
        icon: Icon(
          Icons.logout,
          color: Colors.white,
        ),
      ),
    ],
  );
}
Widget indicator(AnimationController  animationController){
  return CircularProgressIndicator(
    valueColor: animationController
        .drive(ColorTween(begin: Colors.blueAccent, end: Colors.red)),
  );
}