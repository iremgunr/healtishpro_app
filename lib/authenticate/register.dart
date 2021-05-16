import 'package:healtish_app/services/auth.dart';
import 'package:healtish_app/shared/constants.dart';
import 'package:healtish_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:healtish_app/ui/pages/calorie_calculator_screen.dart';


class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Color(0xFFE9E9E9),
      appBar: AppBar(
        backgroundColor: Color(0xFFE0AD61),
        elevation: 0.0,
        title: Text('Sign up',style: TextStyle(color:Color(0XFF200087),fontSize: 20)),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person,color: Color(0XFF200087),),
            label: Text('Sign In',style: TextStyle(color:Color(0XFF200087),fontSize: 20)),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Hero(tag: 'logo',
                child: Container(
                  child: Image.asset('assets/logo.png'),
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'email'),
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'password'),
                obscureText: true,
                validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),

              SizedBox(height: 10.0,),

              RaisedButton(
                color: Color(0XFF200087),
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    setState(() => loading = true);
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    
                    if(result == null) {
                      setState(() {
                        loading = false;
                        error = 'Please supply a valid email';
                      });
                    }else{
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CalorieCalculatorScreen()),);
                    }
                  }
                }
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
    );
  }
}