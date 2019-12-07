import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'mycreatorsize6.dart';

class MyCreatorSize5 extends StatefulWidget {
  final String marketname;
  final String ticket;
  final String tdescription;
  final String comment;
  final List<File> images;

  const MyCreatorSize5({Key key, this.marketname, this.ticket, this.tdescription, this.comment, this.images}): super(key: key);

  @override
  MyCreatorSize5State createState() => MyCreatorSize5State();
}

class MyCreatorSize5State extends State<MyCreatorSize5> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(backgroundColor: Colors.pinkAccent, title: Text("Constat de mesure 5/6")),
        body:  new Container(color: Colors.white,
          child: new Center(
            child: Column(children: [
              new Container(
                padding: EdgeInsets.only(top: 24),
                width: 320,
                height: 60,
                child: new RaisedButton(
                  color: Colors.pinkAccent,
                  shape: RoundedRectangleBorder(side: BorderSide.none, borderRadius: BorderRadius.circular(15)),
                  child: new Text('Etape suivante',
                    textAlign: TextAlign.center,
                    style: new TextStyle(color: Colors.white, fontSize: 30),),
                  onPressed: (){
                    var route = new MaterialPageRoute(
                      builder: (BuildContext context) =>
                      new MyCreatorSize6(marketname: widget.marketname, ticket: widget.ticket, tdescription: widget.tdescription, comment: widget.comment, images: widget.images),
                    );
                    Navigator.of(context).push(route);
                    },
                ),
              ),
              new Padding(padding: new EdgeInsets.all(10.0)),
            ]),
          ),
        )
    );
  }
}