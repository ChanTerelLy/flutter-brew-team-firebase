import 'package:firebase/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/user.dart';
import 'screens/wrapper.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Flutter Demo',
        home: Wrapper(),
      ),
    );
  }
}