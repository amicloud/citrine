import 'package:citrine/auth/sign_in.dart';
import 'package:citrine/controller/UserController.dart';
import 'package:citrine/front_page.dart';
import 'package:citrine/onboarding/user_profile_creation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:citrine/app_loading.dart';
import 'app_loading_error.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

enum Activity { LOADING, SIGN_IN, PROFILE_CREATION, ON_BOARDING, FRONT_PAGE }

class _MyHomePageState extends State<MyHomePage> {
  // Set default `_initialized` and `_error` state to false

  bool _initialized = false;
  bool _error = false;
  int maxFlutterFireInitializationAttempts = 5;
  int currentFlutterFireInitializationAttempts = 0;
  Activity currentPage = Activity.LOADING;
  UserController userController = UserController();

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    print("Initializing FlutterFire.");
    currentFlutterFireInitializationAttempts++;
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await initializeFirebase();
      print("Firebase initialized.");
      initializeFirestore();
      print("Firestore settings set...");
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

  void initializeFirestore() {
    FirebaseFirestore.instance.settings = Settings();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        onUserSignedOut();
      } else {
        onUserSignedIn(user);
      }
    });
  }

  void onUserSignedOut() {
    setState(() {
      print('User signed out!');
    });
  }

  void onUserSignedIn(User user) {
    // We need to get this user's information from our database now

    FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        setState(() {
          print('User ${user.uid} signed in!');
          userController.setLoggedInUser(new CitrineUser(snapshot.data()));
          currentPage = Activity.FRONT_PAGE;
        });
      } else {
        setState(() async {
          print('Creating new profile for user ${user.uid}!');
          await userController.createNewUser(user.uid, {
            "email": user.email,
            "full_name": "",
            "preferred_name": "",
            "profile_picture_url": null,
            "public_profile": null,
            "type": "new",
            "uid": user.uid
          });
          currentPage = Activity.PROFILE_CREATION;
        });
      }
    });
  }

  void getUserData() {}

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
          switch (currentPage) {
            case Activity.LOADING:
              return (Text("Loading..."));
              break;
            case Activity.SIGN_IN:
              return SignIn();
              break;
            case Activity.PROFILE_CREATION:
              return UserProfileCreation();
              break;
            case Activity.ON_BOARDING:
              // TODO: Handle this case.
              break;
          }
          return FrontPage();
        } else {
          return SignIn();
        }
      })),
    );
  }
}
