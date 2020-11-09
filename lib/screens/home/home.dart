import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/model/brew.dart';
import 'package:firebase/screens/home/brew_list.dart';
import 'package:firebase/screens/home/form_settings.dart';
import 'package:firebase/services/auth.dart';
import 'package:firebase/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {


    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: FormSettings(),
        );
      });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
            title: Text('Brew team'),
            backgroundColor: Colors.brown[400],
            actions: <Widget>[
              FlatButton.icon(
                  onPressed: () async {
                    _auth.signOut();
                  },
                  icon: Icon(Icons.person),
                  label: Text('logout')),
              FlatButton.icon(
                  onPressed: () => _showSettingsPanel(),
                  icon: Icon(Icons.settings),
                  label: Text('Settings'))
            ]),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover
            )
          ),
          child: BrewList()
        ),
      ),
    );
  }
}
