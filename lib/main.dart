import 'package:citrine/auth/sign_in.dart';
import 'package:citrine/front_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:citrine/app_loading.dart';
import 'app_loading_error.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

Future main() async {
  await DotEnv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(title: 'Citrine'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Set default `_initialized` and `_error` state to false

  bool _initialized = false;
  bool _error = false;
  int maxFlutterFireInitializationAttempts = 5;
  int currentFlutterFireInitializationAttempts = 0;

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    currentFlutterFireInitializationAttempts++;
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await initializeFirebase();
      setState(() {
        currentFlutterFireInitializationAttempts = 0;
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        onUserSignedOut();
      } else {
        onUserSignedIn();
      }
    });
  }

  void onUserSignedOut() {
    setState(() {
      print('User signed out!');
    });
  }

  void onUserSignedIn() {
    setState(() {
      print('User signed in!');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(child: Builder(builder: (context) {
        if (_error) {
          if (currentFlutterFireInitializationAttempts <
              maxFlutterFireInitializationAttempts) {
            return AppLoadingError(callback: initializeFlutterFire);
          } else {
            return Text("Okay maybe restart then...");
          }
        }
        if (!_initialized) {
          return AppLoading();
        }
        if (FirebaseAuth.instance.currentUser != null) {
          return FrontPage();
        } else {
          return SignIn();
        }
      })),
    );
  }
}
