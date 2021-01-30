import 'package:citrine/auth/sign_in_apple.dart';
import 'package:citrine/auth/sign_in_email.dart';
import 'package:citrine/auth/sign_in_facebook.dart';
import 'package:citrine/auth/sign_in_google.dart';
import 'package:citrine/auth/sign_in_link.dart';
import 'package:citrine/auth/sign_in_phone.dart';
import 'package:citrine/auth/sign_in_twitter.dart';
import 'package:flutter/cupertino.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SignInEmail(),
        SignInFacebook(),
        SignInGoogle(),
        SignInLink(),
        SignInPhone(),
        SignInTwitter(),
        SignInApple()
      ],
    );
  }
}
