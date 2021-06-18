import 'package:healtish_app/services/auth.dart';
import 'package:healtish_app/shared/constants.dart';
import 'package:healtish_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:healtish_app/ui/pages/calorie_calculator_screen.dart';
import 'package:healtish_app/ui/pages/profile_screen.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:url_launcher/url_launcher.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Color(0xFFE9E9E9),
            appBar: AppBar(
              backgroundColor: Color(0xFFE0AD61),
              elevation: 0.0,
              title: Text(
                'Sign in',
                style: TextStyle(color: Color(0XFF200087), fontSize: 20),
              ),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(
                    Icons.person,
                    color: Color(0XFF200087),
                  ),
                  label: Text('Register',
                      style: TextStyle(color: Color(0XFF200087), fontSize: 20)),
                  onPressed: () => widget.toggleView(),
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Hero(
                        tag: 'logo',
                        child: Container(
                            child: Image.asset(
                          'assets/logo.png',
                        )),
                      ),
                      Divider(color: const Color(0xFFE0AD61)),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Please Enter Email'),
                        validator: (val) =>
                            val.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        obscureText: true,
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Please Enter Password'),
                        validator: (val) => val.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      RaisedButton(
                          color: const Color(0XFF200087),
                          child: Text(
                            '  Sign In  ',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic result = await _auth
                                  .signInWithEmailAndPassword(email, password);
                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error =
                                      'Could not sign in with those credentials';
                                });
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfileScreen(
                                            calorie: 1500.0,
                                          )),
                                );
                              }
                            }
                          }),
                      SizedBox(height: 8,),
                      Row(
                       mainAxisAlignment: MainAxisAlignment.center,

                        children: <Widget>[
                          InkWell(
                              child: Text(
                                  "For more info click here to go our website!",style: TextStyle(color: Color(0xFFE0AD61),fontWeight: FontWeight.bold),),
                              onTap: () async {
                                if (await canLaunch(
                                    "http://healtishpro.byethost7.com/website/HealtishPro/gui/index.php")) {
                                  await launch(
                                      "http://healtishpro.byethost7.com/website/HealtishPro/gui/index.php");
                                }
                              })
                        ],
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
