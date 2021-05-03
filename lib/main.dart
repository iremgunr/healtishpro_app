import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:healtish_app/model/user.dart';
import 'package:healtish_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:healtish_app/authenticate/wrapper.dart';
import 'package:healtish_app/authenticate/authenticate.dart';
import 'package:healtish_app/shared/loading.dart';
import 'package:firebase_core/firebase_core.dart';


// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamProvider<UserComponent>.value(
//       value: AuthService().user,
//       child: MaterialApp(
//         home: Wrapper(),
//       ),
//     );
//   }
// }
=======
import 'package:healtish_app/ui/pages/calorie_calculator_screen.dart';
import 'package:healtish_app/ui/pages/home_screen.dart';
import 'package:healtish_app/ui/pages/onboarding_screen.dart';
import 'package:healtish_app/ui/pages/profile_screen.dart';
>>>>>>> d0f71b38f9d72200cff54f279cfd96ff747cdcbb

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
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
=======
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CalorieCalculatorScreen(),
>>>>>>> d0f71b38f9d72200cff54f279cfd96ff747cdcbb

        // Otherwise, show something whilst waiting for initialization to complete
        return Loading();
      },
    );
  }
}
