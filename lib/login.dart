import 'package:accialert/widget.dart';
import 'package:flutter/material.dart';

import 'auth.dart';
import 'helperfunction.dart';
import 'home.dart';

class Login extends StatefulWidget {
  final Function toggle;
  Login(this.toggle);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin{
  TextEditingController email, pass;
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  AuthMethods authMethods = new AuthMethods();
  AnimationController animationController;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }
  @override
  void initState() {
    email = new TextEditingController();
    pass = new TextEditingController();
    super.initState();
    animationController =
        AnimationController(duration: new Duration(seconds: 2), vsync: this);
    animationController.repeat();
  }
  signMeIn() {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      authMethods.SigninWithEmailAndpass(email.text, pass.text).then((val){
        print(val);
        if(val != null){
          HelperFunction.saveUserLoggedInSharedPreference(true);

          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context)=> Home()
          ));
        }
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AccialertApp(context),
      body: isLoading ? Container(child: Center(child: indicator(animationController),),) :Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Login',style: TextStyle(color: Colors.black,fontSize: 25.0, fontWeight: FontWeight.w500)),
            SizedBox(height: 20.0),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (val) {
                      return RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(val)
                          ? null
                          : "Enter correct email";
                    },
                    controller: email,
                    decoration: InputDecoration(
                      hintText: 'Email id',
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    validator: (val) {
                      return val.length >= 6
                          ? null
                          : 'Please provide password 6+ character';
                    },
                    controller: pass,
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                    obscureText: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap:(){
                  signMeIn();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width/2,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            const Color(0xffffAb91),
                            const Color(0xffff5722)
                          ]
                      ),
                      borderRadius: BorderRadius.circular(30)),
                  child: Text('Sign In', style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.w500)),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: TextStyle(fontSize: 16),
                ),
                GestureDetector(
                  onTap: (){
                    widget.toggle();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Sign up now',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
