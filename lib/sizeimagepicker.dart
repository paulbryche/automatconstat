import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'mycreatorsize4.dart';
import 'package:image_picker_modern/image_picker_modern.dart';

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
  List<File> images = <File>[null, null, null, null, null, null,];
  int pos = 0;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (pos < 6) {
      setState(() {images[pos] = image;});
    }
    pos++;
  }

  Future getPhoto() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (pos < 6) {
      setState(() {images[pos] = image;});
    }
    pos++;
  }

  Widget chooseimage(int index, List<File> images){
    if (images[index] != null)
      return (Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.topLeft,
          child: Image.file(images[index])
      ));
    else
      return Text("No Image load");
  }

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
                      onPressed: getPhoto,
                      icon: new Icon(Icons.add_a_photo, size:40 , color: Colors.pinkAccent,), label: Text('appareil')),
                  new Padding(padding: new EdgeInsets.all(10.0)),
                  new RaisedButton.icon(
                      shape: RoundedRectangleBorder(side: BorderSide.none, borderRadius: BorderRadius.circular(15)),
                      onPressed: getImage,
                      icon: new Icon(Icons.add_photo_alternate, size:40, color: Colors.pinkAccent,), label: Text('galerie')),
              ],),
              new Container (
                child: FutureBuilder(
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return ListView(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(20.0),
                          children: List.generate(images.length, (index) {
                            return Center(
                              child: chooseimage(index, images),
                            );
                          }
                          )
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