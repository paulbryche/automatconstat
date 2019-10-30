import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'myparameterstiketsup.dart';

class MyParamsTicketNum extends StatefulWidget {
  @override
  _MyParamsTicketNumState createState() => _MyParamsTicketNumState();
}

class _MyParamsTicketNumState extends State<MyParamsTicketNum> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(backgroundColor: Colors.redAccent, title: Text("Numéros de commande")),
      body: new Container(color: Colors.white,
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                padding: EdgeInsets.only(top: 24),
                width: 280,
                height: 120,
                child: new RaisedButton(
                    color: Colors.redAccent,
                    shape: RoundedRectangleBorder(side: BorderSide.none,
                        borderRadius: BorderRadius.circular(15)),
                    child: new Text('Ajouter un numéro de bon de commande',
                      textAlign: TextAlign.center,
                      style: new TextStyle(color: Colors.white, fontSize: 25),),
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
                  child: new Text('Gérer mes bons de commande',
                    textAlign: TextAlign.center,
                    style: new TextStyle(color: Colors.white, fontSize: 25),),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyParamsTicketSup()),
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