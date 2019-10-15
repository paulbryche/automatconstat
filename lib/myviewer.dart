import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class MyViewer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(backgroundColor: Colors.blueAccent, title: Text("Observer un Constat")),
      body: new Container(color: Colors.white,
        child: new Center(
          child: new Column(
            children: <Widget>[
              new Container(
                padding: EdgeInsets.only(top: 24),
                width: 300,
                height: 60,
                child: new RaisedButton(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(side: BorderSide.none,
                      borderRadius: BorderRadius.circular(15)),
                    child: new Text('Choisir un fichier',
                      style: new TextStyle(color: Colors.white, fontSize: 30),),
                    onPressed: null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}