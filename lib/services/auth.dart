import 'package:firebase/model/user.dart';
import 'package:firebase/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _firebaseUserToUser(FirebaseUser user) {
    return user != null ? User(user.uid) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_firebaseUserToUser);
  }

  // sign anon
  Future signInAnon() async {
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return user;
    } catch(e){
      print(e.toString() + '!!!');
      return null;
    }
  }

  // sign with email & password
  Future signIn(String email, String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _firebaseUserToUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

 // register with email & password
  Future register(String email, String password) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      DatabaseService(uid: user.uid).updateBrew('My Brew', '1', 100);
      return _firebaseUserToUser(user);
    } catch(e){
      print(e.toString());
    }
  }

  // sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}