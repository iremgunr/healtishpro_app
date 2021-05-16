import 'package:firebase_auth/firebase_auth.dart';
import 'package:healtish_app/model/user.dart';
import 'package:healtish_app/authenticate/authenticate.dart';
import 'package:healtish_app/ui/pages/calorie_calculator_screen.dart';
import 'package:healtish_app/ui/pages/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:healtish_app/services/database.dart';
import 'package:healtish_app/services/auth.dart';
import 'package:healtish_app/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool isNew = false;
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  final DatabaseService databaseService = DatabaseService();
  final AuthService _auth = AuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> needCalculate() async {
    await users.where("isNew", isEqualTo: true).snapshots().listen((event) {
      event.docs.forEach((element) {
        print(element.get("email"));
        if (element.get("email").compareTo(_auth.getCurrentUser()) == 1) {
          isNew = true;
        }
      });
    });

    // value.exists ? isNew=false : isNew = true});
    // await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
    //   setState(() {
    //     isUserExists = snapshot.data();
    //   });
    // });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserComponent>(context);

    // return either the Home or Authenticate widget
    // if (user == null) {
    //   return Authenticate();
    // } else {
    //   return ProfileScreen(
    //        calorie: 1500.0,
    //      );

      return Authenticate();
      //this.needCalculate();
      //if (isNew) {
      //  return CalorieCalculatorScreen();
      //} else {
      //   return ProfileScreen(
      //     calorie: 1500.0,
      //   );
      // }
    //}
  }
}
