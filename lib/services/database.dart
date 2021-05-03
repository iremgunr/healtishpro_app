import 'package:healtish_app/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> updateUserData(String email, String password, String name, String surname, String age, String gender, String weight, String height) async {
    return  users.add({
            'email': email,
            'password': password,
            'name': name,
            'surname': surname,
            'age': age,
            'gender': gender,
            'weight': weight,
            'height': height
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));

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
      name: data["name"],
      surname: data["surname"],
      age: data["age"],
      gender: data["gender"],
      weight: data["weight"],
      height: data["height"]
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