import 'package:flutter/material.dart';
import 'myparams.dart';
import 'myviewer.dart';
import 'mycreator.dart';


void main() {
  runApp(MaterialApp(
    title: 'AutomatConstat',
    home: MyHome(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "AutomatConstat",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DefaultTabController(length: 3, child: Scaffold(
        appBar: AppBar(
          title: Text('AutomatConstat'),
          backgroundColor: Colors.grey,
          bottom: TabBar(
              labelStyle: TextStyle(fontSize: 16),
            unselectedLabelColor: Colors.white,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.black12,
            ),
              tabs: [
                Tab(text: "  Générer \nun constat",),
                Tab(text: "Voir un \nconstat",),
                Tab(text: "Paramètres",),
              ]
          ),
        ),
        body: TabBarView(children: [
          new RaisedButton(
            child: new Text("Générer un constat", style: new TextStyle(color: Colors.white, fontSize: 25)),
            color: Colors.deepOrangeAccent,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyCreator()),
              );
            }
          ),
          new RaisedButton(
            child: new Text("Observer un constat",style: new TextStyle(color: Colors.white, fontSize: 25)),
            color: Colors.blueAccent,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyViewer()),
              );
            }
          ),
          new RaisedButton(
            child: new Text("Paramètres", style: new TextStyle(color: Colors.white, fontSize: 25)),
            color: Colors.redAccent,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyParams()),
              );
            }
          ),
        ]),
      )),
    );
  }
}