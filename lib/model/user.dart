class UserComponent {

  final String uid;
  bool isNew=true;
  
  UserComponent({ this.uid,this.isNew=true });

}

class UserData {
  final String uid;
  final String email;
  final String password;
  final bool isNew;
  final String name;
  final String surname;
  final String age;
  final String gender;
  final String weight;
  final String height;

  UserData({ this.uid, this.email, this.password,this.isNew, this.name,this.surname,this.age ,this.gender,this.weight,this.height });
}
