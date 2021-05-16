import 'package:firebase_core/firebase_core.dart';
import 'package:healtish_app/model/user.dart';
import 'package:healtish_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healtish_app/authenticate/wrapper.dart';


class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Wrapper _wrapper = Wrapper();
  // create user obj based on firebase user
  UserComponent _userFromFirebaseUser(User user) {
    return user != null ? UserComponent(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<UserComponent> get user {
    return FirebaseAuth.instance.authStateChanges()
       .map(_userFromFirebaseUser);
  }

  String getCurrentUser(){
    return _auth.currentUser.email;
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return result;
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      // create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData(email,true);
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

}