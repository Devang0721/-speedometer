import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signUpWithEmailAndPass(String email, String pass) async{
    try{
      FirebaseUser authResult= await _auth.createUserWithEmailAndPassword(email: email, password: pass);
      return authResult != null ? true : false;
    }catch(e){
      print(e.toString());
    }
  }

  Future SigninWithEmailAndpass (String email, String pass) async{
    try{
      FirebaseUser userCredential = await _auth.signInWithEmailAndPassword(email: email, password: pass);
      return userCredential != null ? true : false;
    }catch(e){
      print(e.toString());
    }
  }

  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
    }
  }
}