import 'package:citrine/auth/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInEmail extends StatefulWidget {
  SignInEmail({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignInEmailState();
}

class _SignInEmailState extends State<SignInEmail> {
  _SignInEmailState();

  final _formKey = GlobalKey<FormState>();

  final emailEditController = TextEditingController();
  final passwordEditController = TextEditingController();
  bool _showingModal = false;

  @override
  Widget build(BuildContext context) {
    if (_showingModal) {
      return SimpleDialog(
          children: <Widget>[
            Text("Sign in with your email and password"),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                    validator: (value) {
                      //TODO: email validation
                      if (value.isEmpty) {
                        return 'Please enter your email address.';
                      }
                      return null;
                    },
                    controller: emailEditController,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                    validator: (value) {
                      //TODO: password validation
                      if (value.isEmpty) {
                        return 'Please enter your password.';
                      }
                      return null;
                    },
                    controller: passwordEditController,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        if (_formKey.currentState.validate()) {
                          bool res = await doSignIn(emailEditController.text,
                              passwordEditController.text);
                          if (res)
                            setState(() {
                              _showingModal = false;
                            });
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ]);
    } else {
      return (RaisedButton(
        onPressed: () {
          setState(() {
            _showingModal = true;
          });
        },
        child: Text("Sign-in with Email"),
      ));
    }
  }

  Future<bool> doSignIn(_email, _password) async {

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return false;
    }
    print("User authentication successful.");
      return true;
  }
}
