import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:healtish_app/services/auth.dart';
import 'package:healtish_app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({Key key}) : super(key: key);

  @override
  _AnalysisScreenState createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  final AuthService _auth = AuthService();
  final DatabaseService databaseService = DatabaseService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Analysis", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),
        ),
        backgroundColor: const Color(0XFF200087),
      ),
    body: _buildBody(context),
    );
  }
  Widget _buildBody(context){
    return StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('calorie').snapshots(),
      builder: (context,snapshot){
      if(!snapshot.hasData){
        return LinearProgressIndicator();
      }else{
      }


      }
    );

  }
}
