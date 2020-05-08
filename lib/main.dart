import 'package:flutter/material.dart';
import 'package:resistorcombinator/pages/colorResistance.dart';
import 'package:resistorcombinator/pages/colorcode.dart';
import 'package:resistorcombinator/pages/combinations.dart';
import 'package:resistorcombinator/pages/instructions.dart';
import 'package:resistorcombinator/pages/mainscreen.dart';
import 'package:resistorcombinator/pages/loading.dart';
import 'package:resistorcombinator/pages/chooseApp.dart';
import 'package:resistorcombinator/pages/colorResistance.dart';
import 'package:resistorcombinator/pages/instructions.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/main',
  routes: {
    '/main': (context) => Choose(),
    '/': (context) => Home(),
    '/info': (context) => Instructions(),
    '/colortoRes': (context) => ResistanceFind(),
    '/combination': (context) => Combination(),
    '/code': (context) => Code(),
    '/load': (context) => Load(),
  },
));

