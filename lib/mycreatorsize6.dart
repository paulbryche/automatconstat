import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

//for signature
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;

//pdf generation
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'pdfsizegenerator.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';

class MyCreatorSize6 extends StatefulWidget {
  final String marketname;
  final String ticket;
  final String tdescription;
  final String comment;
  final List<File> images;

  const MyCreatorSize6({Key key, this.marketname, this.ticket, this.tdescription, this.comment, this.images}): super(key: key);

  @override
  _MyCreatorSize6State createState() => _MyCreatorSize6State();
}

class _MyCreatorSize6State extends State<MyCreatorSize6> {
  GlobalKey<SignatureState> signatureKey = GlobalKey();
  var image;
  var enterprisename = TextEditingController();
  final pdf = pw.Document();


  Future writeOnPdf() async {
    final marianne = await get_pdf_image('pdf_files/marianne.png');

    Directory directory = await getApplicationDocumentsDirectory();
    String signature_editor_path = directory.path + "/Signatures/mysignature.png";
    final signature_editor = await get_pdf_image(signature_editor_path);

    Directory tmpdirectory = await getApplicationDocumentsDirectory();
    String tmpsignature_editor_path = tmpdirectory.path + "/TmpSignatures/tmpsignature.png";
    final tmpsignature_editor = await get_pdf_image(tmpsignature_editor_path);

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
              pw.Text("Numéro de Bon: " + widget.ticket, textScaleFactor: 1.62),
              pw.Padding(padding: pw.EdgeInsets.all(3),),
              pw.Text("Opération de Bon: " + widget.tdescription, textScaleFactor: 1.62),
              pw.Padding(padding: pw.EdgeInsets.all(10),),
              pw.Paragraph(
                text: widget.comment,
                style: pw.TextStyle(fontSize: 16),
              ),
              pw.Row(
                  verticalDirection: pw.VerticalDirection.down,
                  mainAxisAlignment : pw.MainAxisAlignment.center,
                  children:  [
                    pw.Text("Réprésentant CIR: " + name, textScaleFactor: 1),
                    pw.Padding(padding: pw.EdgeInsets.all(30),),
                    pw.Text("Responsable Entreprise: " + enterprisename.text, textScaleFactor: 1),
                  ]
              ),
              pw.Row(
                  verticalDirection: pw.VerticalDirection.down,
                  mainAxisAlignment : pw.MainAxisAlignment.center,
                  children:  [
                    pw.Image(signature_editor, width:200, height:200),
                    pw.Padding(padding: pw.EdgeInsets.all(40),),
                    pw.Image(tmpsignature_editor, width:200, height:200),
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

    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    // the downloads folder path
    Directory tempDir = await DownloadsPathProvider.downloadsDirectory;
    String tempPath = tempDir.path;

    File file = File("$tempPath/final_pdf.pdf");

    file.writeAsBytesSync(await pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(backgroundColor: Colors.pinkAccent, title: Text("Constat de mesure 6/6")),
      body: new Container(color: Colors.white,
        child: new Center(
          child: new Column(
            children: <Widget>[
              new Padding(padding: new EdgeInsets.all(10.0)),
              new Container(
                decoration: ShapeDecoration(
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 6, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15)),),
                width: 300,
                height: 55,
                child: TextField(
                  maxLines: null,
                  controller: enterprisename,
                  keyboardType: TextInputType.multiline,
                  style: new TextStyle(color: Colors.white, fontSize: 18,),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 6.0),
                      ),
                      hintText: 'Signataire entreprise'
                  ),
                ),
              ),
              new Padding(padding: new EdgeInsets.all(10.0)),
              new Container(
                decoration: ShapeDecoration(
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 8, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15)),),
                width: 300,
                height: 350,
                child: Signature(key: signatureKey),
              ),
              new Padding(padding: new EdgeInsets.all(5.0)),
              new Container(
                padding: EdgeInsets.only(top: 24),
                width: 250,
                height: 60,
                child: new RaisedButton(
                  color: Colors.pinkAccent,
                  shape: RoundedRectangleBorder(side: BorderSide.none,
                      borderRadius: BorderRadius.circular(15)),
                  child: new Text('Effacer',
                    textAlign: TextAlign.center,
                    style: new TextStyle(color: Colors.white, fontSize: 26),),
                  onPressed: (){
                    signatureKey.currentState.clearPoints();
                  },
                ),
              ),
              new Padding(padding: new EdgeInsets.all(5.0)),
              new Container(
                padding: EdgeInsets.only(top: 24),
                width: 290,
                height: 80,
                child: new RaisedButton(
                    color: Colors.pinkAccent,
                    shape: RoundedRectangleBorder(side: BorderSide.none,
                        borderRadius: BorderRadius.circular(15)),
                    child: new Text('Fininaliser le constat',
                      textAlign: TextAlign.center,
                      style: new TextStyle(color: Colors.white, fontSize: 27),),
                  onPressed: () async {
                    await setRenderedImage(context);
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
            ],
          ),
        ),
      ),
    );
  }

  setRenderedImage(BuildContext context) async {
    ui.Image renderedImage = await signatureKey.currentState.rendered;

    setState(() {
      image = renderedImage;
    });

    showImage(context);
  }

  Future<Null> showImage(BuildContext context) async {
    var pngBytes = await image.toByteData(format: ui.ImageByteFormat.png);
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    await Directory('$path/TmpSignatures').create();
    directory.list(recursive: true, followLinks: false)
        .listen((FileSystemEntity entity) {
      print(entity.path);
    });
    File('$path/TmpSignatures/tmpsignature.png')
        .writeAsBytesSync(pngBytes.buffer.asInt8List());
  }
}

class Signature extends StatefulWidget {
  Signature({Key key}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SignatureState();
  }
}

class SignatureState extends State<Signature> {

  List<Offset> _points = <Offset>[];

  Future<ui.Image> get rendered {
    ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas canvas = Canvas(recorder);
    SignaturePainter painter = SignaturePainter(points: _points);
    var size = context.size;
    painter.paint(canvas, size);
    return recorder.endRecording()
        .toImage(size.width.floor(), size.height.floor());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GestureDetector(
          onPanUpdate: (DragUpdateDetails details) {
            setState(() {
              RenderBox _object = context.findRenderObject();
              Offset _locationPoints = _object.localToGlobal(details.globalPosition);
              _points = new List.from(_points)..add(_locationPoints);
            });
          },
          onPanEnd: (DragEndDetails details) {
            setState(() {
              _points.add(null);
            });
          },
          child: CustomPaint(
            painter: SignaturePainter(points: _points),
            size: Size.infinite,
          ),
        ),
      ),
    );
  }

  void clearPoints() {
    setState(() {
      _points.clear();
    });
  }
}

class SignaturePainter extends CustomPainter {
  List<Offset> points = <Offset>[];
  final pos = Offset(110.00, 355.00);

  SignaturePainter({this.points});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.butt
      ..strokeWidth = 2.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i] - pos, points[i + 1] - pos, paint);
      }
    }
  }

  @override
  bool shouldRepaint(SignaturePainter oldDelegate) => oldDelegate.points != points;
}