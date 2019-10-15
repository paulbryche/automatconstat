import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class MyCreatorDate5 extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<MyCreatorDate5> {
  List<Offset> _points = <Offset>[];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepOrangeAccent, title: Text("Constat d'événement 5/5")),
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
                height: 400,
                child: new GestureDetector(
                  onPanUpdate: (DragUpdateDetails details) {
                    setState(() {
                      RenderBox object = context.findRenderObject();
                      Offset _localPosition =
                      object.globalToLocal(details.globalPosition);
                      _points = new List.from(_points)..add(_localPosition);
                    });
                  },
                  onPanEnd: (DragEndDetails details) => _points.add(null),
                  child: new CustomPaint(
                    painter: new Signature(points: _points),
                    size: Size.infinite,
                  ),
                ),
              ),
              new Padding(padding: new EdgeInsets.all(10.0)),
              new Container(
                padding: EdgeInsets.only(top: 24),
                width: 320,
                height: 60,
                child: new RaisedButton(
                    color: Colors.deepOrangeAccent,
                    shape: RoundedRectangleBorder(side: BorderSide.none,
                        borderRadius: BorderRadius.circular(15)),
                    child: new Text('Fininaliser le constat',
                      textAlign: TextAlign.center,
                      style: new TextStyle(color: Colors.white, fontSize: 30),),
                    onPressed: null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Signature extends CustomPainter {
  List<Offset> points;
  final mesure = Offset(0.00, 80.00);

  Signature({this.points});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.butt
      ..strokeWidth = 2.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i] - mesure, points[i + 1] - mesure, paint);
      }
    }
  }

  @override
  bool shouldRepaint(Signature oldDelegate) => oldDelegate.points != points;
}