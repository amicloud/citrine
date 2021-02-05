import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../model/user_model.dart';

class UserController {
  CitrineUser loggedInUser;

  UserController._privateConstructor();

  static final UserController _instance = UserController._privateConstructor();

  factory UserController() {
    return _instance;
  }

  Future<CitrineUser> createNewUser(
      String uid, Map<String, dynamic> _data) async {
    DocumentReference value = await FirebaseFirestore.instance
        .collection("users")
        .add(_data);
    DocumentSnapshot userDoc = await value.get();
    return setLoggedInUser(new CitrineUser(userDoc.data()));
  }

  CitrineUser setLoggedInUser(CitrineUser _user) {
    loggedInUser = _user;
    print('Hi, ${loggedInUser.preferredName}!');
    return loggedInUser;
  }

  Future<CitrineUser> updateFullName(String _fullName) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(loggedInUser.uid)
        .update({"full_name": _fullName}).then((value) {
      loggedInUser.fullName = _fullName;
    });
    return loggedInUser;
  }

  Future<CitrineUser> getUser(String uid) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get();
    if(doc.exists){
      return setLoggedInUser(new CitrineUser(doc.data()));
    } else {
      throw new Exception("User not found!");
    }
  }

  bool isUserProfileComplete(CitrineUser _user){

  }

  bool updatePreferredName(String _name) {}

  Future<CitrineUser> updateUserData(Map<String, dynamic> _data) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(loggedInUser.uid)
        .update(_data)
        .then((value) {
    });
  }

  bool verifyMap(Map<String, dynamic> _data) {}
}
