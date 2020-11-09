import 'package:firebase/model/user.dart';
import 'package:firebase/services/auth.dart';
import 'package:firebase/shared/constants.dart';
import 'package:firebase/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function _toggleView;

  Register(this._toggleView);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email = '';
  String password = '';
  String error = '';

  final _formKey = GlobalKey<FormState>();
  AuthService _auth = AuthService();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: Text('Register'),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                widget._toggleView();
              },
              icon: Icon(Icons.person),
              label: Text('Sign In'))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: textFormDecoration.copyWith(hintText: 'Email'),
                validator: (value) => value.isEmpty ? 'Please enter email' : null,
                onChanged: (val) => {setState(() => email = val)},
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: true,
                validator: (value) => value.length < 6 ? 'Password required 6+ chars' : null,
                decoration: textFormDecoration.copyWith(hintText: 'Password'),
                onChanged: (val) => {setState(() => password = val)},
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                  child: Text('Sign Up'),
                  color: Colors.pink[100],
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.register(email, password);
                      if(result == null){
                        setState(() {
                          loading = false;
                          error = 'Incorrect email';
                        });
                      }
                    }
                  }),
              SizedBox(
                height: 10,
              ),
              Text(error, style: TextStyle(color: Colors.red),),
            ],
          ),
        ),
      ),
    );
  }
}
