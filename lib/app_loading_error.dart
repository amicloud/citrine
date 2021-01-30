
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppLoadingError extends StatelessWidget {
  final Function callback;

  const AppLoadingError({Key key, this.callback}) : super(key: key);
  @override
  Widget build(BuildContext context){
    return (
    Center (
      child: Container (
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [Text("Error connecting to the service. Are you connected to the internet?"), RaisedButton(onPressed: this.callback, child: Text("Retry."),)],
        )
      ),
    )
    );
  }
}