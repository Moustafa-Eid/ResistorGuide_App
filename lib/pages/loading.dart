import 'package:flutter/material.dart';
import 'package:resistorcombinator/calculations/findCombinations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';

class Load extends StatefulWidget {
  @override
  _LoadState createState() => _LoadState();
}

Map data = {};

class _LoadState extends State<Load> {

  // Calls Find Combinations and after it loads it navigates to listview screen.
  void setupCombinations () async {
    FindCombinations comb1 = FindCombinations(data['Resistance'],data['Multiplier'],data['Tolerance'],data['Url']);
    final combinations = await comb1.loadCombinations();
    Navigator.pushReplacementNamed(context, '/combination', arguments: {
      'combinations': combinations,
      'Tolerance':data['Tolerance'],
    });
  }



  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    Timer(
        Duration(seconds: 2),
            () => setupCombinations()
    );


    return Hero(
      tag: 'dash',
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Center(
          child: SpinKitChasingDots(
            size: 50.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
