import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'mycreatorsize4.dart';

class MyCreatorSize3 extends StatefulWidget {
  final String marketname;
  final String ticket;
  final String tdescription;

  const MyCreatorSize3({Key key, this.marketname, this.ticket, this.tdescription}): super(key: key);

  @override
  _MyCreatorSize3State createState() => _MyCreatorSize3State();
}

class _MyCreatorSize3State extends State<MyCreatorSize3> {
  var comment = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(backgroundColor: Colors.pinkAccent ,title: Text("Constat de mesure 3/5")),
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
                  controller: comment,
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
                      var route = new MaterialPageRoute(
                        builder: (BuildContext context) =>
                        new MyCreatorSize4(marketname: widget.marketname, ticket: widget.ticket, tdescription: widget.tdescription, comment: comment.text),);
                      Navigator.of(context).push(route).then((bool) {Navigator.pop(context,true);});
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