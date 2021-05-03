import 'package:healtish_app/model/user.dart';
import 'package:healtish_app/authenticate/authenticate.dart';
import 'package:healtish_app/ui/pages/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserComponent>(context);
    
    // return either the Home or Authenticate widget
    if (user == null){
      return Authenticate();
    } else {
      return ProfileScreen();
    }
  } 
}   
  