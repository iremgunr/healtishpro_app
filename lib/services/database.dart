import 'package:healtish_app/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healtish_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:starfruit/starfruit.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference calories =
      FirebaseFirestore.instance.collection('calories');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addUserCalorieInfo(
      int age,
      int weight,
      int height,
      bool gender,
      String email,
      int calorie,
      int frequencySport,
      DateTime registerDate) async {
    return calories
        .add({
          'age': age,
          'weight': weight,
          'height': height,
          'gender': gender,
          'email': email,
          'calorie': calorie,
          'frequencySport': frequencySport,
          'registerDate': registerDate
        })
        .then((value) => print("User Calorie Information Added"))
        .catchError((error) => print("Failed to add Calorie Info : $error"));
  }

//Kullanıcnın kilo verisini liste olarak verir parametre olarak _auth.getCurrentUser() verilmeli
  Future<List<double>> getCurrentUserWeightData(String email) async {
    List<double> weightList = new List();
    await calories.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot doc) {
        if (email == doc['email'].toString()) {
          weightList.add(doc['weight'].toDouble());
        }
      });
    });
    return weightList;
  }

//Kullanıcnın spor verisini liste olarak verir parametre olarak _auth.getCurrentUser() verilmeli
  Future<List<double>> getCurrentUserSportData(String email) async {
    List<double> sportFrequencyList = [];
    await calories.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot doc) {
        if (email == doc['email'].toString()) {
          sportFrequencyList.add(doc['frequencySport'].toDouble());
        }
      });
    });
    return sportFrequencyList;
  }

  //Kullanıcnın kilo ve spor verisine göre correlation datasını verir parametre olarak _auth.getCurrentUser() verilmeli
  Future<double> getCorrelationCoefficient(String email) async {
    List<double> weightList = [];
    List<double> sportFrequencyList = [];

    await getCurrentUserWeightData(email).then((value) => {weightList = value});
    await getCurrentUserSportData(email)
        .then((value) => {sportFrequencyList = value});

    Map<double, double> stats = {};
    for (var i = 0; i < weightList.length; i++) {
      stats.putIfAbsent(weightList[i], () => sportFrequencyList[i]);
    }

    return stats.corCoefficient;
  }

  Future<void> updateUserData(String email, bool isNew) async {
    return users
        .add({
          'email': email,
          'isNew': isNew,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> updateUserIsNewData(String email, bool isNew) async {
    return users
        .doc(_auth.currentUser.uid)
        .update({
          'email': email,
          'isNew': isNew,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data();

    return UserData(
      uid: uid,
      email: data["email"],
      password: data["password"],
    );
  }

  // get user doc stream
  Stream<UserData> get userData {
    return users.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
