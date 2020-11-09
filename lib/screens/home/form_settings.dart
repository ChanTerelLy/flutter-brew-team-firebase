import 'package:firebase/model/user.dart';
import 'package:firebase/services/database.dart';
import 'package:firebase/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormSettings extends StatefulWidget {
  @override
  _FormSettingsState createState() => _FormSettingsState();
}

class _FormSettingsState extends State<FormSettings> {
  final _formKey = GlobalKey<FormState>();

  String _currentName;
  String _currentSugar;
  int _currentStrength;

  final List<String> sugars = ['0', '1', '2', '3', '4'];

  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          UserData userData = snapshot.data;
          return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                  key: _formKey,
                  child: Column(children: <Widget>[
                    Text(
                      'Settings',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      initialValue: userData.name,
                      decoration: textFormDecoration.copyWith(hintText: 'Name'),
                      validator: (val) => val.isEmpty ? 'Enter a name' : null,
                      onChanged: (val) {
                        _currentName = val;
                      },
                    ),
                    SizedBox(height: 10.0),
                    DropdownButtonFormField(
                      value: _currentSugar ?? userData.sugar,
                      decoration: textFormDecoration,
                      items: sugars.map((sugar) {
                        return DropdownMenuItem(
                          value: sugar,
                          child: Text('$sugar sugars'),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _currentSugar = val),
                    ),
                    SizedBox(height: 10.0),
                    Slider(
                      value: (_currentStrength ?? userData.strength)
                          .toDouble(),
                      activeColor: Colors.brown[_currentStrength ?? userData.strength],
                      inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                      onChanged: (value) =>
                          setState(() => _currentStrength = value.round()),
                      divisions: 8,
                      max: 900.0,
                      min: 100.0,
                    ),
                    RaisedButton(
                        color: Colors.pink[400],
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            print(_currentName ?? snapshot.data.name);
                            print(_currentSugar ?? snapshot.data.sugar);
                            print(_currentStrength ?? snapshot.data.strength);
                            DatabaseService(uid: user.uid).
                            updateBrew(
                                _currentName ?? snapshot.data.name,
                                _currentSugar ?? snapshot.data.sugar,
                                _currentStrength ?? snapshot.data.strength
                            );
                            Navigator.pop(context);
                          }
                        }),
                  ])));
        });
  }
}
