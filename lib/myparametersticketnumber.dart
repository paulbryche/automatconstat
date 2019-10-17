import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'myparameterstiketsup.dart';

class MyParamsTicketNum extends StatefulWidget {
  @override
  _MyParamsTicketNumState createState() => _MyParamsTicketNumState();
  }

  class _MyParamsTicketNumState extends State<MyParamsTicketNum> {
  var number = TextEditingController();
  var ope = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(backgroundColor: Colors.redAccent, title: Text("Numéros de commande")),
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
                  controller: number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 6.0),
                      ),
                      hintText: 'Numéro de Bon'
                  ),
                ),
              ),
              new Padding(padding: new EdgeInsets.all(20.0)),
              new Container(
                decoration: ShapeDecoration(
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 6, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15)),),
                width: 280,
                height: 60,
                child: TextField(
                  style: new TextStyle(color: Colors.white, fontSize: 25),
                  controller: ope,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 6.0),
                      ),
                      hintText: 'Opération'
                  ),
                ),
              ),
              new Padding(padding: new EdgeInsets.all(20.0)),
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
                padding: EdgeInsets.only(top: 24),
                width: 280,
                height: 120,
                child: new RaisedButton(
                    color: Colors.redAccent,
                    shape: RoundedRectangleBorder(side: BorderSide.none,
                        borderRadius: BorderRadius.circular(15)),
                    child: new Text('Ajouter un numéro de bon de commande',
                      textAlign: TextAlign.center,
                      style: new TextStyle(color: Colors.white, fontSize: 25),),
                    onPressed: null,
                ),
              ),
              new Padding(padding: new EdgeInsets.all(20.0)),
              new Container(
                padding: EdgeInsets.only(top: 24),
                width: 280,
                height: 120,
                child: new RaisedButton(
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(side: BorderSide.none,
                      borderRadius: BorderRadius.circular(15)),
                  child: new Text('Gérer mes bons de commande',
                    textAlign: TextAlign.center,
                    style: new TextStyle(color: Colors.white, fontSize: 25),),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyParamsTicketSup()),
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
  void saveticket() {
    String _number = number.text;
    String _ope = ope.text;
    _saveticket(_number, _ope).then((bool commited) {
      Navigator.pop(context,true);});
  }
}

Future<bool> _saveticket(String number, String ope) async {
  if (number != null && number != "" && ope != null && ope != "")

    return true;
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