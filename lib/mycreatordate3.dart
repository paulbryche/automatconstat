import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'mycreatordate4.dart';

class MyCreatorDate3 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepOrangeAccent, title: Text("Constat d'événement 3/5")),
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
                child: new Text("Type de Constat:",textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 25)),
              ),
              new Padding(padding: new EdgeInsets.all(10.0)),
              new Container(
                decoration: ShapeDecoration(
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 6, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15)),),
                width: 290,
                height: 120,
                child: MyStatefulWidget(),
              ),
              new Padding(padding: new EdgeInsets.all(10.0)),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyCreatorDate4()),
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
          height: 120,
          color: Colors.grey,
          child:Center(
            child: new Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.grey,),
              child: DropdownButton<String>(
                iconEnabledColor: Colors.grey,
                iconDisabledColor: Colors.grey,
                iconSize: 0,
                value: dropdownValue,
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                  },
                items: <String>["Choisir", "état des lieux","piquetage prncipale",
                "piquetage secondaire","piquetage spécial",
                "reconnaissance des itinéraires\nde transport de matériaux",
                "installation de chantier", "signalisations temporaires",
                "signalisations permanentes", "démarrage des travaux",
                "travaux non prévus", "hygiène et sécurité (CSPS)",
                "présence de réseaux inconnus\nou non répertoriés dans DICT",
                "présence d'ouvrage non\nrecensés", "défaut d'ouvrage temporaire",
                "dommage causé aux tiers", "constat de surcharge",
                "présence d'autre intervenants\nsur le chantier",
                "présence d'un sous-traitant\nnon accepté",
                "conformité de la mise en\noeuvre des matériaux",
                "dommages causés aux\nouvrages", "ddp",
                "conformité des matériaux\napprovisionnés",
                "interruption des travaux",
                "mesure d'éviction à l'encontre\ndu personnel",
                "phénomènes naturels/évenements sociaux", "évenement au contractuel marché"]
                    .map<DropdownMenuItem<String>>((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                          style: new TextStyle(backgroundColor: Colors.grey,color: Colors.white, fontSize: 19),
                        ),
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