import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'mycreatorsize6.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

import 'pdfsizegenerator.dart';

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

  writeOnPdf(){
    pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a5,
          margin: pw.EdgeInsets.all(32),

          build: (pw.Context context){
            return <pw.Widget>  [
              pw.Header(
                  level: 0,
                  child: pw.Text(widget.marketname) 
              ),

            pw.Paragraph(
                  text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."
              ),

              pw.Paragraph(
                  text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."
              ),

              pw.Header(
                  level: 1,
                  child: pw.Text("Second Heading")
              ),

              pw.Paragraph(
                  text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."
              ),

              pw.Paragraph(
                  text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."
              ),

              pw.Paragraph(
                  text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."
              ),
            ];
          },
        )
    );

    for (int i = 0; i < 6; i++) {
      if (widget.images[i] != null) {
        final image = PdfImage.file(
          pdf.document,
          bytes: widget.images[i].readAsBytesSync(),
        );

        pdf.addPage(pw.Page(
            build: (pw.Context context) {
              return pw.Center(
                child: pw.Image(image),
              ); // Center
            })); // Page
      }
    }

  }

  Future savePdf() async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    String documentPath = documentDirectory.path;

    File file = File("$documentPath/temporary.pdf");

    file.writeAsBytesSync(pdf.save());
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
                    onPressed: ()async{
                      writeOnPdf();
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