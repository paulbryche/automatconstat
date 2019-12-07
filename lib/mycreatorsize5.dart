import 'dart:io';
import 'dart:async';

import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:path_provider/path_provider.dart';

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
  String generatedPdfFilePath;

  @override
  void initState() {
    super.initState();
    generateExampleDocument();
  }

  Future<void> generateExampleDocument() async {
    var htmlContent = """
    <!DOCTYPE html>
    <html>
    <head>
        <style>
        table, th, td {
          border: 1px solid black;
          border-collapse: collapse;
        }
        th, td, p {
          padding: 5px;
          text-align: left;
        }
        </style>
      </head>
      <body>
        <h2>PDF Generated with flutter_html_to_pdf plugin</h2>

        <table style="width:100%">
          <caption>Sample HTML Table</caption>
          <tr>
            <th>Month</th>
            <th>Savings</th>
          </tr>
          <tr>
            <td>January</td>
            <td>100</td>
          </tr>
          <tr>
            <td>February</td>
            <td>50</td>
          </tr>
        </table>

        <p>Image loaded from web</p>
        <img src="https://i.imgur.com/wxaJsXF.png" alt="web-img">
      </body>
    </html>
    """;

    Directory appDocDir = await getApplicationDocumentsDirectory();
    var targetPath = appDocDir.path;
    var targetFileName = "example-pdf";

    var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
        htmlContent, targetPath, targetFileName);
    generatedPdfFilePath = generatedPdfFile.path;
  }

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