import 'package:flutter/material.dart';

class Lastpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text("payment"), backgroundColor: Colors.deepOrange),
        body: new Container(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                children: <Widget>[
                  new IconButton(
                      icon: new Icon(Icons.favorite, color: Colors.redAccent),
                      iconSize: 70.0,
                      onPressed:() => {}),
                  new Text("Paytm", textAlign: TextAlign.center,
                   style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  new IconButton(
                      icon: new Icon(Icons.favorite, color: Colors.blueAccent),
                      iconSize: 70.0,
                      onPressed: () => {}),
                     
                          new Text("Freecharge", textAlign: TextAlign.center,
                          style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          ),
                          
                      ),
                  
                  
                ],
              ),
              Row(
                children: <Widget>[
                  new IconButton(
                      icon: new Icon(Icons.favorite, color: Colors.lightGreen),
                      iconSize: 70.0,
                      onPressed: () => {}),
                  new Text("Bhim_UPI", textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
