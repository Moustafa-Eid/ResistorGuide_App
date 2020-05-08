import 'dart:math';
import 'dart:async' show Future;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:collection';
import 'package:vector_math/vector_math.dart';
import 'dart:core';

class FindCombinations {
  FindCombinations(double r, double m, double t, String url) {
    textResistance = r;
    multiplier = m;
    tolerance = t;
    this.url = url;
    temp = (log(m*r) / log(10));
    temp = double.parse((temp).toStringAsFixed(2));
    decade = temp.floor();
    if (decade > 6) {
      decade = 6;
    }
  }

  double textResistance;
  double multiplier;
  double tolerance;
  int decade;
  double temp;
  String url;
  Future<List<double>> values;


  // z = 0 means series
  // z = 1 means parallel
  // z = 2 means single
  // Loads all the info for the resistor combinations calculator to be sent to front end for displaying
  Future<List<Vector3>> loadCombinations() async {
    double resistance = textResistance * multiplier;
    final contents = await rootBundle.loadString(url);
    final listContents = contents.split('\n');
    final listResistances = listContents.map(double.parse).toList();
    final listConductances = totalArray2(listResistances, resistance).map((r) => 1/r).toList().reversed.toList().where((v) => v <= (1/resistance)).toList();
    final listSeriesRes = totalArray(listResistances, resistance).where((v) => v <= (resistance)).toList();
    final allComb = findAllCombinations(listSeriesRes, listConductances, resistance, totalArray(listResistances, resistance));
    return allComb;
  }

  // Gathers all functions and gets a final list for resistor combinations
  List<Vector3> findAllCombinations(List<double> resistance, List<double> conductance, double desired, List<double> all) {
    final seriesComb = findDouble(resistance, desired,true);
    final parallelComb = findDouble(conductance, 1/desired,false);
    List<Vector3> allComb = List<Vector3>();
    int index = binarySearch(all, desired);
    if (index != -1) {
      allComb.add(Vector3(all[index], 0,2));
    }
    allComb.addAll(seriesComb);
    allComb.addAll(parallelComb);

    return allComb;
  }

  // changes file values to array of all resistances [Series]
  List<double> totalArray(List<double> values, double res) {
    List<double> arr = List<double>();
    for (int i = 0; i <= decade; i++) {
      for (int j = 0; j < values.length; j++) {
        arr.add(double.parse((values[j] * (pow(10, i))).toStringAsPrecision(3)));
      }
    }
    return arr;
  }

  // changes file values to array of all resistances [Parallel] using Conductance
  List<double> totalArray2(List<double> values, double res) {
    List<double> arr = List<double>();
    for (int i = 0; i <= 6; i++) {
      for (int j = 0; j < values.length; j++) {
        arr.add(
            double.parse((values[j] * (pow(10, i))).toStringAsPrecision(3)));
      }
    }
    return arr;
  }

  // Calculates the combinations of parallel or series resistors to create a desired resistance
  List<Vector3> findDouble(List<double> values, double desired,bool isSeries) {
    List<Vector3> pairs = List<Vector3>();
    double  num;
    if (values.length == 0) {
      return pairs;
    }
    for (int i = values.length - 1; values[i] >= (desired / 2.0) && i >= 0; i--) {
      num = findClosest(values, desired-values[i]);
      if ((((num+values[i])/desired)-1).abs() <= 0.025) {
        if (isSeries == true) {
          pairs.add(Vector3(values[i], num,0));
        }
        else {
          pairs.add(Vector3(1/values[i], 1/num,1));
        }
      }
      else if(num == values[i] && values.length == 1) {
        break;
      }
      if(i == 0) {
        break;
      }
    }

    return pairs;
  }

  // Binary search that finds the closest value in an array given a value
  double findClosest(List<double> arr, double target) {
    int n = arr.length;

    // Corner cases
    if (target <= arr[0]) return arr[0];
    if (target >= arr[n - 1]) return arr[n - 1];

    // Doing binary search
    int i = 0, j = n, mid = 0;
    while (i < j) {
      mid = ((i + j) / 2).truncate();

      if (arr[mid] == target) return arr[mid];

      /* If target is less than array element,
               then search in left */
      if (target < arr[mid]) {
        // If target is greater than previous
        // to mid, return closest of two
        if (mid > 0 && target > arr[mid - 1])
          return getClosest(arr[mid - 1], arr[mid], target);

        /* Repeat for left half */
        j = mid;
      }

      // If target is greater than mid
      else {
        if (mid < n - 1 && target < arr[mid + 1])
          return getClosest(arr[mid], arr[mid + 1], target);
        i = mid + 1; // update i
      }
    }

    return arr[mid];
  }

  // Helper function for findClosest()
  double getClosest(double val1, double val2, double target) {
    if (target - val1 >= val2 - target)
      return val2;
    else
      return val1;
  }
}
