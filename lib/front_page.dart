
import 'package:citrine/top_bar.dart';
import 'package:flutter/cupertino.dart';

class FrontPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FrontPageState();
  
}

class _FrontPageState extends State<FrontPage> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // TopBar(),
        Placeholder(),
      ]
    );
  }
}