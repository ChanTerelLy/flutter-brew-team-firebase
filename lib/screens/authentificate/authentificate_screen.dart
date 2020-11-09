import 'package:firebase/screens/authentificate/register.dart';
import 'package:firebase/screens/authentificate/sign_in.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool showSignIn = true;
  void toggleView(){
    //print(showSignIn.toString());
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if(!showSignIn){
      return Register(toggleView);
    } else {
      return SignIn(toggleView);
    }
  }
}
