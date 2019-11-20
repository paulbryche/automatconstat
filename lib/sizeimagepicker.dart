import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

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
  List images;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(backgroundColor: Colors.pinkAccent, title: Text("Constat de mesure 5/5")),
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
                  onPressed: null,
                ),
              ),
              new Padding(padding: new EdgeInsets.all(10.0)),
              new Container (
                child: FutureBuilder(
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return ListView.builder(
                        padding: const EdgeInsets.all(10.0),
                        itemCount: snapshot.data.length,
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