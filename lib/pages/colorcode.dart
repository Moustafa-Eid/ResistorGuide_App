import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'dart:typed_data';
import 'package:resistorcombinator/calculations/painter.dart';
import 'package:resistorcombinator/calculations/findColors.dart';

class Code extends StatefulWidget {
  @override
  _CodeState createState() => _CodeState();
}

class _CodeState extends State<Code> {
  ui.Image image;
  bool isImageloaded = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  // Loads Image Initially
  Future <Null> init() async {
    final ByteData data = await rootBundle.load('images/0.png');
    image = await loadImage( Uint8List.view(data.buffer));
  }

  // Loads image as byte code for CustomPainter to understand
  Future<ui.Image> loadImage(List<int> img) async {
    final Completer<ui.Image> completer =  Completer();
    ui.decodeImageFromList(img, (ui.Image img) {
      setState(() {
        isImageloaded = true;
      });
      return completer.complete(img);
    });
    return completer.future;
  }

  FindColors r1;
  FindColors r2;

  Map data = {};
  Map id = {
    40.0:1,
    20.0:1,
    10.0:2,
    5.0:2,
    2.0:3,
    1.0:3,
    0.5:3,
  };

  Widget body() {
    double factorW = 1;
    double factorH = 1;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: <Widget>[
            Text(
              'Orientation:',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            Text(
              'In ${data['orientation']}',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Text(
              'Resistor #1',
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
            isImageloaded ?
            FittedBox(
              alignment: Alignment.center,
              child: SizedBox(
                width: image.width.toDouble()*factorW,
                height: image.height.toDouble()*factorH,
                child: CustomPaint(
                  painter: myPainter(
                    image: image,
                    factorW: factorW,
                    factorH: factorH,
                    color: r1.getColors(r1.getDigits()),
                    id: id[data['Tolerance']],
                  ),
                ),
              ),
            )
                :
            Text("Loading"),
            Text(
              data['value1'],
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ],
        ),
        (isImageloaded && data['R2'] != 0) ?
        Column(
          children: <Widget>[
            Text(
              'Resistor #2',
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
            FittedBox(
              child: SizedBox(
                width: image.width.toDouble()*factorW,
                height: image.height.toDouble()*factorH,
                child: CustomPaint(
                  painter: myPainter(
                    image: image,
                    factorW: factorW,
                    factorH: factorH,
                    color: r2.getColors(r2.getDigits()),
                    id: id[data['Tolerance']],
                  ),
                ),
              ),
            ),
            Text(
              data['value2'],
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ],
        ):
        Text(
          'Single Resistance',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    r1 = FindColors(data['R1'],data['Tolerance']);
    r2 = FindColors(data['R2'],data['Tolerance']);
    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Color Code'),
      ),
      body: SafeArea(
        child: OrientationBuilder(
            builder: (context, orientation) {
              if(orientation == Orientation.portrait) {
                return body();
              }
              else {
                return SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 30),
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height,
                        minWidth:  MediaQuery.of(context).size.width,
                      ),
                      child: body(),
                  ),
                );
              }
            }
        ),
      ),
    );
  }
}

