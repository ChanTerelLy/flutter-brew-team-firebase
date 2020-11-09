import 'package:firebase/model/user.dart';
import 'package:firebase/screens/authentificate/authentificate_screen.dart';
import 'package:firebase/screens/authentificate/register.dart';
import 'package:firebase/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    if(user == null){
      return AuthScreen();
    } else {
      return Home();
    }
  }
}
