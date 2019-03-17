import 'package:flutter/material.dart';

class SuggestionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text("Suggestion"), backgroundColor: Colors.deepOrange),
        body: new Container(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[ 
              Text("Blue Item",
                textAlign: TextAlign.center,
                style: new TextStyle(
                fontWeight: FontWeight.bold,
                ),
              )
            ]
        )
        )
    );
  }
}
