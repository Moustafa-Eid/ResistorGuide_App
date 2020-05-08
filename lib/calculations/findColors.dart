import 'dart:math';
import 'package:flutter/material.dart';

class FindColors {
  FindColors(double resistance, double tolerance) {
    this.resistance = resistance;
    this.tolerance = tolerance;
  }
  double resistance;
  double tolerance;
  double temp;
  int decade;

  Map digitColors = {
    0:Colors.black,
    1:Colors.brown,
    2:Colors.red,
    3:Colors.orange,
    4:Colors.yellow,
    5:Colors.green,
    6:Colors.blue,
    7:Color(0xffEE82EE),
    8:Colors.grey[700],
    9:Colors.white,
    -1:Color(0xffFFD700),
    -2:Color(0xffC0C0C0),
  };

  Map toleranceColors = {
    40.0:Colors.transparent,
    20.0:Colors.transparent,
    10.0:Colors.grey,
    5.0:Color(0xffFFD700),
    2.0:Colors.red,
    1.0:Colors.brown,
    0.5:Colors.green,
  };

  // Transforms a resistance in to a list of digits to be translated to colors
  List<int> getDigits() {
    Color red = digitColors[0];
    List<int> digits = List<int>();
    String number = resistance.toStringAsFixed(2);
    for(int i = 0; i < number.length; i++) {
      if (int.tryParse(number[i]) != null) {
        digits.add(int.parse(number[i]));
      }
    }
    return digits;
  }

  // gets the color combination given a list of digits and creates a paint object for them
  Map getColors(List<int> digits) {
    List<int> newDigits = List<int>();
    newDigits.addAll(digits);
    if(digits[0] != 0) {
      for (int i = newDigits.length - 1; i >= 0; i--) {
        if (newDigits[i] == 0) {
          newDigits.removeLast();
        }
        else {
          break;
        }
      }
    }
    else {
      newDigits.removeLast();
    }
    String tempDigit = newDigits.join();
    double resDigit = double.parse(tempDigit);

    if (newDigits.length == 1) {
      newDigits.add(0);
      newDigits.add(0);
    }
    else if (newDigits.length == 2) {
      newDigits.add(0);
    }
    temp = (log(resistance/resDigit) / log(10));
    temp = double.parse((temp).toStringAsFixed(2));
    decade = temp.floor();
    Map combination = {
      'D1':new Paint() ..color = digitColors[newDigits[0]] ..style = PaintingStyle.fill,
      'D2':new Paint() ..color = digitColors[newDigits[1]] ..style = PaintingStyle.fill,
      'D3':new Paint() ..color = digitColors[newDigits[2]] ..style = PaintingStyle.fill,
      'Multiplier':new Paint() ..color = digitColors[decade] ..style = PaintingStyle.fill,
      'Tolerance':new Paint() ..color = toleranceColors[tolerance] ..style = PaintingStyle.fill,
    };
    return combination;
  }



}