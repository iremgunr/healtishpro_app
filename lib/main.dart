import 'package:flutter/material.dart';
import 'package:healtish_app/model/user.dart';
import 'package:healtish_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:healtish_app/authenticate/wrapper.dart';
import 'package:healtish_app/authenticate/authenticate.dart';
import 'package:healtish_app/shared/loading.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Authenticate();
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<UserComponent>.value(
            value: AuthService().user,
            child: MaterialApp(
              home: Wrapper(),
            ),
          );
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return Loading();
      },
    );
  }
}
