// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
//
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
//
// class SignInFacebook extends StatefulWidget {
//   final callback;
//
//   const SignInFacebook({Key key, this.callback})
//       : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() =>
//       _SignInFacebookState(callback: callback);
// }
//
// class _SignInFacebookState extends State<SignInFacebook> {
//   final callback;
//
//   void doFacebookLogin() {
//     print("We're doin' a loggy face!");
//   }
//
//   _SignInFacebookState({this.callback});
//
//   @override
//   Widget build(BuildContext context) {
//     return (RaisedButton(
//       onPressed: doFacebookLogin,
//       child: Text("Facebook Login"),
//     ));
//   }
// }
//
// Future<UserCredential> signInWithFacebook() async {
//   // Trigger the sign-in flow
//   final AccessToken result = await FacebookAuth.instance.login();
//
//   // Create a credential from the access token
//   final FacebookAuthCredential facebookAuthCredential =
//   FacebookAuthProvider.credential(result.token);
//
//   // Once signed in, return the UserCredential
//   return await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
// }