import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'mycreatordate3.dart';

class MyCreatorDate2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepOrangeAccent, title: Text("Constat d'événement 2/5")),
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
                height: 70,
                child: new Text("Numéro de Bon de marché:",textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 25)),
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
                child: MyStatefulWidget(),
              ),
              new Padding(padding: new EdgeInsets.all(10.0)),
              new Container(
                decoration: ShapeDecoration(
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 6, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15)),),
                width: 250,
                height: 45,
                child: new Text("Marché lié:",textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 25)),
              ),
              new Padding(padding: new EdgeInsets.all(10.0)),
              new Container(
                decoration: ShapeDecoration(
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 6, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15)),),
                width: 250,
                height: 45,
                child: new Text("N°Marché",textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 25)),
              ),
              new Padding(padding: new EdgeInsets.all(30.0)),
              new Container(
                padding: EdgeInsets.only(top: 24),
                width: 240,
                height: 60,
                child: new RaisedButton(
                  color: Colors.deepOrangeAccent,
                  shape: RoundedRectangleBorder(side: BorderSide.none,
                      borderRadius: BorderRadius.circular(15)),
                  child: new Text('Etape suivante',
                    textAlign: TextAlign.center,
                    style: new TextStyle(color: Colors.white, fontSize: 30),),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyCreatorDate3()),
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

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String dropdownValue = 'Choisir';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          height: 60,
          color: Colors.grey,
          child:Center(
            child: new Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.grey,),
              child: DropdownButton<String>(
                iconEnabledColor: Colors.white,
                iconDisabledColor: Colors.grey,
                iconSize: 60,
                value: dropdownValue,
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                  },
                items: <String>['Choisir','ONE', 'TWO', 'THREE', 'FOUR']
                    .map<DropdownMenuItem<String>>((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
//                        child: new Container(
//                          color: Colors.grey,
                          child: Text(value,
                            style: new TextStyle(backgroundColor: Colors.grey,color: Colors.white, fontSize: 25),),
//                        ),
                      );
                    }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}