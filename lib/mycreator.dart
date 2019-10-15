import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:automatconstat/mycreatorsize1.dart';
import 'mycreatordate1.dart';

class MyCreator extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepOrangeAccent,
          title: Text("Générer un Constat")),
      body: new Container(color: Colors.white,
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                width: 300,
                height: 60,
                child: new RaisedButton(
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(side: BorderSide.none,
                      borderRadius: BorderRadius.circular(15)),
                  child: new Text('Constat de Mesure',
                    style: new TextStyle(color: Colors.white, fontSize: 30),),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyCreatorSize()),
                      );
                    }
                ),
              ),
              new Padding(padding: new EdgeInsets.all(30.0)),
              new Container(
                width: 320,
                height: 60,
                child: new RaisedButton(
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(side: BorderSide.none,
                      borderRadius: BorderRadius.circular(15)),
                  child: new Text("Constat d'événement",
                    style: new TextStyle(color: Colors.white, fontSize: 30),),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyCreatorDate()),
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