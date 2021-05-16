import 'package:healtish_app/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healtish_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';



class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  final CollectionReference calories = FirebaseFirestore.instance.collection('calories');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // var document = FirebaseFirestore.instance.collection('calories');
  
  Future<void> addUserCalorieInfo(int age,int weight,int height,bool gender,String email, int calorie) async {
      return calories.add({
        'age':age,
        'weight':weight,
        'height':height,
        'gender':gender,
        'email':email,
        'calorie':calorie
      })
      .then((value)=> print("User Calorie Information Added"))
      .catchError((error)=> print("Failed to add Calorie Info : $error"));
  }

  Future<String> checkhUserCalorieDataExits(String email)async{

  // calories.snapshots().listen((data){
  //     data.docs.forEach((doc){
  //       if(email==doc['email']){
  //         return true;
  //       }});
  //       return false;
  //    });
  //   print("checkhUserCalorieDataExits-$result");
  //   return result.toString();
  }

  Future<void> updateUserData(String email, bool isNew) async {
    return  users.add({
            'email': email,
            'isNew':isNew,
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));

  }
   Future<void> updateUserIsNewData(String email,bool isNew) async {
    return users.doc(_auth.currentUser.uid).update({
            'email': email,
            'isNew':isNew,
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to update user: $error"));

  }

  // // brew list from snapshot
  // List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.documents.map((doc){
  //     //print(doc.data);
  //     return Brew(
  //       name: doc.data['name'] ?? '',
  //       strength: doc.data['strength'] ?? 0,
  //       sugars: doc.data['sugars'] ?? '0'
  //     );
  //   }).toList();
  // }

  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data();
    
    return UserData(
      uid: uid,
      email: data["email"],
      password: data["password"],

    );
  }

  // get brews stream
  // Stream<List<Brew>> get brews {
  //   return users.snapshots()
  //     .map(_brewListFromSnapshot);
  // }

  // get user doc stream
  Stream<UserData> get userData {
    return users.doc(uid).snapshots()
      .map(_userDataFromSnapshot);
  }

}