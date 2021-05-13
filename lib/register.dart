import 'package:accialert/widget.dart';
import 'package:flutter/material.dart';
import 'auth.dart';
import 'helperfunction.dart';
import 'home.dart';

class Register extends StatefulWidget {
  final Function toggle;
  Register(this.toggle);
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> with TickerProviderStateMixin{
  final formKey = GlobalKey<FormState>();

  TextEditingController Username, email, pass;
  bool isLoading = false;
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
    Username = new TextEditingController();
    email = new TextEditingController();
    pass = new TextEditingController();
    super.initState();
    animationController =
        AnimationController(duration: new Duration(seconds: 2), vsync: this);
    animationController.repeat();
  }
  signMeUp() {
    if (formKey.currentState.validate()) {

      HelperFunction.saveUserEmailSharedPreference(email.text);
      HelperFunction.saveUsernameSharedPreference(Username.text);

      setState(() {
        isLoading = true;
      });
      authMethods.signUpWithEmailAndPass(email.text, pass.text).then((val) {
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
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Register',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w500)),
              SizedBox(height: 20.0),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (val) {
                        return val.isEmpty || val.length < 4
                            ? "Please provide username"
                            : null;
                      },
                      controller: Username,
                      decoration: InputDecoration(
                        hintText: 'Username',
                      ),
                    ),
                    SizedBox(height: 20.0),
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
                  onTap: () {
                    signMeUp();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width / 2,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          const Color(0xffffAb91),
                          const Color(0xffff5722)
                        ]),
                        borderRadius: BorderRadius.circular(30)),
                    child: Text('Sign up',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500)),
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
                    onTap: () {
                      widget.toggle();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Sign in now',
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
