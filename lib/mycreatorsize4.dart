import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'mycreatorsize5.dart';

class MyCreatorSize4 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(backgroundColor: Colors.pinkAccent ,title: Text("Constat de mesure 4/5")),
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
                width: 300,
                height: 250,
                child: TextField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  style: new TextStyle(color: Colors.white, fontSize: 18,),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 6.0),
                      ),
                      hintText: 'Description'
                  ),
                ),
              ),
              new Padding(padding: new EdgeInsets.all(20.0)),
              new Container(
                padding: EdgeInsets.only(top: 24),
                width: 240,
                height: 60,
                child: new RaisedButton(
                  color: Colors.pinkAccent,
                  shape: RoundedRectangleBorder(side: BorderSide.none,
                      borderRadius: BorderRadius.circular(15)),
                  child: new Text('Etape suivante',
                    textAlign: TextAlign.center,
                    style: new TextStyle(color: Colors.white, fontSize: 30),),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyCreatorSize5()),
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