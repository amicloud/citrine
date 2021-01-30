import 'package:flutter/cupertino.dart';

class TopBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(children: [
        Center(
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Top Bar Like Search Area"))),
        Expanded(
            child: Container(
                child: Placeholder(), padding: EdgeInsets.only(right: 10))),
      ]),
    );
  }
}
