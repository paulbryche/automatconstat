import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'myparametersmarketnumber.dart';
import 'myparametersticketnumber.dart';
import 'myparamssignature.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyParams extends StatefulWidget {
  @override
  _MyParamsState createState() => _MyParamsState();
}

class _MyParamsState extends State<MyParams> {
  var name = TextEditingController();
  var first = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(backgroundColor: Colors.redAccent ,title: Text("Paramètres")),
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
                  controller: name,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Nom'
                  ),
                ),
              ),
              new Padding(padding: new EdgeInsets.all(10.0)),
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
                  controller: first,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 6.0),
                      ),
                      hintText: 'Prénom'
                  ),
                ),
              ),
              new Padding(padding: new EdgeInsets.all(10.0)),
              new Container(
                width: 250,
                height: 60,
                child: new RaisedButton(
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(side: BorderSide.none,
                      borderRadius: BorderRadius.circular(15)),
                  child: new Text('Signature',
                    style: new TextStyle(color: Colors.white, fontSize: 25),),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyParamsSignature()),
                      );
                    }
                ),
              ),
              new Padding(padding: new EdgeInsets.all(10.0)),
              new Container(
                width: 250,
                height: 60,
                child: new RaisedButton(
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(side: BorderSide.none,
                      borderRadius: BorderRadius.circular(15)),
                  child: new Text('N° de Marché',
                    style: new TextStyle(color: Colors.white, fontSize: 25),),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyParamsMarketNum()),
                      );
                    }
                ),
              ),
              new Padding(padding: new EdgeInsets.all(10.0)),
              new Container(
                width: 250,
                height: 60,
                child: new RaisedButton(
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(side: BorderSide.none,
                      borderRadius: BorderRadius.circular(15)),
                  child: new Text('N° de Commande',
                    style: new TextStyle(color: Colors.white, fontSize: 25),),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyParamsTicketNum()),
                      );
                    }
                ),
              ),
              new Padding(padding: new EdgeInsets.all(10.0)),
              new Container(
                padding: EdgeInsets.only(top: 24),
                width: 240,
                height: 60,
                child: new RaisedButton(
                    color: Colors.redAccent,
                    shape: RoundedRectangleBorder(side: BorderSide.none,
                        borderRadius: BorderRadius.circular(15)),
                    child: new Text('Sauvegarder',
                      textAlign: TextAlign.center,
                      style: new TextStyle(color: Colors.white, fontSize: 30),),
                    onPressed: () {
                      savename();
                    },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void savename() {
    String _name = name.text;
    String _first = first.text;
    _savename(_name, _first).then((bool commited) {
    Navigator.pop(context,true);});
  }
}

Future<bool> _savename(String name, String first) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if(name != null && name != "")
    prefs.setString("name", name);
  if(first != null && first != "")
    prefs.setString("first", first);
  return true;
}