
import 'package:flutter/cupertino.dart';

class AppLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (
        Center (
          child: Container (
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: Text("Loading...")
          ),
        )
    );
  }

}