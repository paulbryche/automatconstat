import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'dart:io';
import 'dart:ui' as ui;

class MyParamsSignature extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<MyParamsSignature> {
  GlobalKey<SignatureState> signatureKey = GlobalKey();
  var image;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(backgroundColor: Colors.redAccent, title: Text("Signature")),
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
                height: 350,
                child: Signature(key: signatureKey),
              ),
              new Container(
                padding: EdgeInsets.only(top: 24),
                width: 200,
                height:60,
                child: new RaisedButton(
                  color: Colors.redAccent,
                  shape: RoundedRectangleBorder(side: BorderSide.none,
                      borderRadius: BorderRadius.circular(15)),
                  child: new Text('Effacer',
                    textAlign: TextAlign.center,
                    style: new TextStyle(color: Colors.white, fontSize: 30),),
                  onPressed: (){
                    signatureKey.currentState.clearPoints();
                  },
                ),
              ),
              new Container(
                padding: EdgeInsets.only(top: 24),
                width: 320,
                height: 60,
                child: new RaisedButton(
                    color: Colors.redAccent,
                    shape: RoundedRectangleBorder(side: BorderSide.none,
                        borderRadius: BorderRadius.circular(15)),
                    child: new Text('Valider ma signature',
                      textAlign: TextAlign.center,
                      style: new TextStyle(color: Colors.white, fontSize: 30),),
                    onPressed: (){
                      setRenderedImage(context);
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
    await Directory('$path/Signatures').create();
    directory.list(recursive: true, followLinks: false)
        .listen((FileSystemEntity entity) {
      print(entity.path);
    });
    File('$path/Signatures/mysignature.png')
        .writeAsBytesSync(pngBytes.buffer.asInt8List());
    return showDialog<Null>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Image.memory(Uint8List.view(pngBytes.buffer)),
          );
        }
    );
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
  final pos = Offset(40.00, 200.00);

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