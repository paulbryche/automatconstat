import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'myparametersmarketsup.dart';

class MyParamsMarketNum extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(backgroundColor: Colors.redAccent, title: Text("Numéros de marché")),
      body: new Container(color: Colors.white,
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                decoration: ShapeDecoration(
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 6, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15)),),
                width: 250,
                height: 60,
                child: TextField(
                  style: new TextStyle(color: Colors.white, fontSize: 25),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 6.0),
                      ),
                      hintText: 'Numéro de Marché'
                  ),
                ),
              ),
              new Padding(padding: new EdgeInsets.all(20.0)),
              new Container(
                decoration: ShapeDecoration(
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 6, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15)),),
                width: 280,
                height: 60,
                child: TextField(
                  style: new TextStyle(color: Colors.white, fontSize: 25),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 6.0),
                      ),
                      hintText: 'Opération liée(optionel)'
                  ),
                ),
              ),
              new Padding(padding: new EdgeInsets.all(10.0)),
              new Container(
                padding: EdgeInsets.only(top: 24),
                width: 290,
                height: 120,
                child: new RaisedButton(
                    color: Colors.redAccent,
                    shape: RoundedRectangleBorder(side: BorderSide.none,
                        borderRadius: BorderRadius.circular(15)),
                    child: new Text('Ajouter un numéro \nde marché',
                      textAlign: TextAlign.center,
                      style: new TextStyle(color: Colors.white, fontSize: 30),),
                    onPressed: null,
                ),
              ),
              new Padding(padding: new EdgeInsets.all(20.0)),
              new Container(
                padding: EdgeInsets.only(top: 24),
                width: 280,
                height: 120,
                child: new RaisedButton(
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(side: BorderSide.none,
                      borderRadius: BorderRadius.circular(15)),
                  child: new Text('Gérer mes numéros de bon de commande',
                    textAlign: TextAlign.center,
                    style: new TextStyle(color: Colors.white, fontSize: 25),),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyParamsMarketSup()),
                      );
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}