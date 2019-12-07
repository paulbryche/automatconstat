import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'mycreatorsize5.dart';
import 'package:image_picker/image_picker.dart';

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

  void sortlist(){
    int len = 0;

    while (len < 5) {
      if (images[len] == null && images[len + 1] != null) {
        images[len] = images[len + 1];
        images[len + 1] = null;
        len++;
      }
      else
        len++;
    }
  }

  Future supandsort(int sup) {
    if (images[sup] != null) {
      images[sup] = null;
      if (pos != 0)
        setState(() {pos--;});
      sortlist();
    }
    print(sup);
    print(pos);
  }

  Widget chooseimage(int index, List<File> images){
    if (images[index] != null)
      return (Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.topCenter,
          child: Image.file(images[index], width: 300,)
      ));
    else
      return Text("No Image load");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(backgroundColor: Colors.pinkAccent, title: Text("Constat de mesure 4/6")),
      body:  new Container(color: Colors.white,
        child: new Center(
          child: new LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints:
                  BoxConstraints(minHeight: viewportConstraints.maxHeight),
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
                            new MyCreatorSize5(marketname: widget.marketname, ticket: widget.ticket, tdescription: widget.tdescription, comment: widget.comment, images: images),
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
                    new Padding(padding: new EdgeInsets.all(10.0)),
                    new GestureDetector(
                      onLongPress: () => supandsort(0),
                      child: chooseimage(0, images),),
                    new Padding(padding: new EdgeInsets.all(10.0)),
                    new GestureDetector(
                      onLongPress: () => supandsort(1),
                      child: chooseimage(1, images),),
                    new Padding(padding: new EdgeInsets.all(10.0)),
                    new GestureDetector(
                      onLongPress: () => supandsort(2),
                      child: chooseimage(2, images),),
                    new Padding(padding: new EdgeInsets.all(10.0)),
                    new GestureDetector(
                      onLongPress: () => supandsort(3),
                      child: chooseimage(3, images),),
                    new Padding(padding: new EdgeInsets.all(10.0)),
                    new GestureDetector(
                      onLongPress: () => supandsort(4),
                      child: chooseimage(4, images),),
                    new Padding(padding: new EdgeInsets.all(10.0)),
                    new GestureDetector(
                      onLongPress: () => supandsort(5),
                      child: chooseimage(5, images),
                    ),
                    new Padding(padding: new EdgeInsets.all(20.0)),
                  ]),
                ),
              );
              },
          )
        ),
      )
    );
  }
}