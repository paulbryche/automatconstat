import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'mycreatorsize4.dart';

class SizeImagePicker extends StatefulWidget {
  final String marketname;
  final String ticket;
  final String tdescription;
  final String comment;

  const SizeImagePicker({Key key, this.marketname, this.ticket, this.tdescription, this.comment}): super(key: key);

  @override
  SizeImagePickerState createState() => SizeImagePickerState();
}

class SizeImagePickerState extends State<SizeImagePicker> {
  List images = null;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(backgroundColor: Colors.pinkAccent, title: Text("Constat de mesure 4/6")),
      body: new Container(color: Colors.white,
        child: new Center(
          child: new Column(
            children: <Widget>[
              new Container(
                padding: EdgeInsets.only(top: 24),
                width: 320,
                height: 60,
                child: new RaisedButton(
                  color: Colors.pinkAccent,
                  shape: RoundedRectangleBorder(side: BorderSide.none,
                      borderRadius: BorderRadius.circular(15)),
                  child: new Text('Etape suivante',
                    textAlign: TextAlign.center,
                    style: new TextStyle(color: Colors.white, fontSize: 30),),
                  onPressed: (){
                    var route = new MaterialPageRoute(
                      builder: (BuildContext context) =>
                      new MyCreatorSize4(marketname: widget.marketname, ticket: widget.ticket, tdescription: widget.tdescription, comment: widget.comment),
                    );
                    Navigator.of(context).push(route);
                  },
                ),
              ),
              new Padding(padding: new EdgeInsets.all(10.0)),
              new ButtonBar(alignment: MainAxisAlignment.center, children: <Widget>[
                  new RaisedButton.icon(
                      shape: RoundedRectangleBorder(side: BorderSide.none, borderRadius: BorderRadius.circular(15)),
                      onPressed: null,
                      icon: new Icon(Icons.add_a_photo, size:40 , color: Colors.pinkAccent,), label: Text('appareil')),
                  new Padding(padding: new EdgeInsets.all(10.0)),
                  new RaisedButton.icon(
                      shape: RoundedRectangleBorder(side: BorderSide.none, borderRadius: BorderRadius.circular(15)),
                      onPressed: null,
                      icon: new Icon(Icons.add_photo_alternate, size:40, color: Colors.pinkAccent,), label: Text('galerie')),
              ],),
              new Container (
                child: FutureBuilder(
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return ListView.builder(
                        padding: const EdgeInsets.all(10.0),
                        itemCount: images.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: new Image(image: images[index],),
                          );
                        },
                      );
                  },
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}