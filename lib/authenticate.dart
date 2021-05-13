
import 'package:accialert/register.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  @override
  Widget build(BuildContext context) {
    return showSignIn ? Login(toggleView) : Register(toggleView);
  }
  void toggleView(){
    setState(() {
      showSignIn = !showSignIn;
    });
  }

}
