import 'file:///C:/Users/Amy/StudioProjects/citrine/lib/model/user_model.dart';
import 'package:citrine/controller/UserController.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProfileCreation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserProfileCreationState();
}

class _UserProfileCreationState extends State<UserProfileCreation> {
  CitrineUser newUser;

  final _formKey = GlobalKey<FormState>();
  final nameEditController = TextEditingController();
  final preferredNameEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return (Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Text("Sign in with your email and password"),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Person von MacPerson',
                  ),
                  validator: (value) {
                    //TODO: email validation
                    if (value.isEmpty) {
                      return 'Please enter your full name.';
                    }
                    return null;
                  },
                  controller: nameEditController,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Persey',
                  ),
                  validator: (value) {
                    //TODO: password validation
                    if (value.isEmpty) {
                      return 'And what should we call you?';
                    }
                    return null;
                  },
                  controller: preferredNameEditController,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      UserController userController = UserController();

                      // FirebaseFirestore.instance
                      //     .collection("users")
                      //     .doc(userController.loggedInUser.uid)
                      //     .update({
                      //   "preferred_name": preferredNameEditController.text,
                      //   "full_name": nameEditController.text
                      // });
                    },
                    child: Text('Done.'),
                  ),
                ),
              ],
            ),
          ),
        ]));
  }
}
