import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

class SignInTwitter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (RaisedButton(child: Text("Twitter"), onPressed: signInWithTwitter));
  }
}

Future<UserCredential> signInWithTwitter() async {
  // Create a TwitterLogin instance
  final TwitterLogin twitterLogin = new TwitterLogin(
    consumerKey: DotEnv.env["TWITTER_API_KEY"],
    consumerSecret: DotEnv.env["TWITTER_API_SECRET_KEY"],
  );

  // Trigger the sign-in flow
  final TwitterLoginResult loginResult = await twitterLogin.authorize();

  // Get the Logged In session
  final TwitterSession twitterSession = loginResult.session;

  // Create a credential from the access token
  final AuthCredential twitterAuthCredential = TwitterAuthProvider.credential(
      accessToken: twitterSession.token, secret: twitterSession.secret);

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance
      .signInWithCredential(twitterAuthCredential);
}
