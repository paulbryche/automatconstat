import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'pdfsizegenerator.dart';

import 'package:shared_preferences/shared_preferences.dart';

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
  final pdf = pw.Document();


  Future writeOnPdf() async {
    final marianne = await get_pdf_image('pdf_files/marianne.png');

    Directory directory = await getApplicationDocumentsDirectory();
    String signature_editor_path = directory.path + "/Signatures/mysignature.png";
    final signature_editor = await get_pdf_image(signature_editor_path);

    final name = await getname();

    pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: pw.EdgeInsets.all(32),
          build: (pw.Context context){
            return <pw.Widget>  [
              pw.Row(
                  verticalDirection: pw.VerticalDirection.up,
                  mainAxisAlignment : pw.MainAxisAlignment.center,
                children:  [
                  pw.Image(marianne,width:300 ,height:200),
                ]
              ),
              pw.Header(
                  level: 0,
                  child: pw.Text("Numéro de Marché: " + widget.marketname, textScaleFactor: 2)
              ),
              pw.Text("Numéro de Bon: " + widget.ticket + " / " + widget.tdescription, textScaleFactor: 1.62),
              pw.Padding(padding: pw.EdgeInsets.all(10),),
              pw.Paragraph(
                  text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed.",
                  style: pw.TextStyle(fontSize: 16),
              ),
              pw.Row(
                  verticalDirection: pw.VerticalDirection.down,
                  mainAxisAlignment : pw.MainAxisAlignment.center,
                  children:  [
                    pw.Text("Réprésentant CIR: " + name, textScaleFactor: 1),
                    pw.Padding(padding: pw.EdgeInsets.all(30),),
                    pw.Text("Responsable Entreprise: " + widget.marketname, textScaleFactor: 1),
                  ]
              ),
              pw.Row(
                  verticalDirection: pw.VerticalDirection.down,
                  mainAxisAlignment : pw.MainAxisAlignment.center,
                  children:  [
                    pw.Image(signature_editor, width:200, height:200),
                    pw.Padding(padding: pw.EdgeInsets.all(40),),
                    pw.Image(signature_editor, width:200, height:200),
                  ]
              ),
            ];
          },
        )
    );
    for (int i = 0; i < 6; i++) {
      if (widget.images[i] != null) {
        final image = pw.MemoryImage(File(widget.images[i].path).readAsBytesSync(),);

        pdf.addPage(pw.Page(
            build: (pw.Context context) {
              return pw.Center(
                child: pw.Image(image,),
              ); // Center
            })); // Page
      }
    }
  }

  Future getname() async {
    String name;
    String first_name;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    name = prefs.getString("name");
    first_name = prefs.getString("first");

    if (name == null)
      return ("");
    if (name != null && first_name != null)
      name = name + " " + first_name;
    return (name);
  }

  Future get_pdf_image(String path) async {
    final image = pw.MemoryImage((await rootBundle.load(path)).buffer.asUint8List(),);
    return (image);
  }

  Future savePdf() async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    String documentPath = documentDirectory.path;

    File file = File("$documentPath/temporary.pdf");

    file.writeAsBytesSync(await pdf.save());
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(backgroundColor: Colors.pinkAccent,
          title: Text("Constat de mesure 5/6")),
      body:new Container(color: Colors.white,
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
                new Container(
                  padding: EdgeInsets.only(top: 24),
                  width: 320,
                  height: 60,
                  child: new RaisedButton(
                    color: Colors.pinkAccent,
                    shape: RoundedRectangleBorder(side: BorderSide.none, borderRadius: BorderRadius.circular(15)),
                    child: new Text('Voir le pdf',
                      textAlign: TextAlign.center,
                      style: new TextStyle(color: Colors.white, fontSize: 30),),
                    onPressed: () async {
                      new SnackBar(duration: new Duration(seconds: 4), content: new Row(
                        children: <Widget>[
                          new CircularProgressIndicator(),
                          new Text("  Signing-In...")
                        ],
                      ),
                      );
                      await writeOnPdf();
                      await savePdf();
                      Directory documentDirectory = await getApplicationDocumentsDirectory();
                      String documentPath = documentDirectory.path;
                      String fullPath = "$documentPath/temporary.pdf";
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => PdfPreviewScreen(path: fullPath,)
                      ));
                    },
                  ),
                ),
              ])
          )
      ),
    );
  }
}