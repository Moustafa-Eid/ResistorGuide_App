import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:resistorcombinator/calculations/findColors.dart';

class Combination extends StatefulWidget {
  @override
  _CombinationState createState() => _CombinationState();
}

// Gets Orientation of Resistors
String getOrientation(double num) {
  int x = num.round();
  switch(x) {
    case 0:
      return 'Series';
    case 1:
      return 'Parallel';
    default:
      return 'Single';
  }
}

// Function to format resistance values for displaying
String formatNum(double num) {
  int decade;
  double temp;
  if(num > 0) {
    temp = (log(num) / log(10));
    temp = double.parse((temp).toStringAsFixed(2));
    decade = temp.floor();
  }
  else {
    decade = 0;
  }
  switch(decade) {
    case 3:
      return "${(num/1000).toStringAsFixed(2)} kΩ";
    case 4:
      return "${(num/1000).toStringAsFixed(2)} kΩ";
    case 5:
      return "${(num/1000).toStringAsFixed(2)} kΩ";
    case 6:
      return "${(num/1000000).toStringAsFixed(2)} MΩ";
    default:
      return "${num.toStringAsFixed(2)} Ω";
  }
}

// Alert Dialog to catch edge cases and errors
Future<void> _Alert(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('No Results'),
        content: const Text('This resistance cannot be created using standard resistors.\n\nPlease enter a different resistance value.'),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Map combinations = {};
class _CombinationState extends State<Combination> {
  @override
  Widget build(BuildContext context) {
    combinations = ModalRoute.of(context).settings.arguments;
    final arr = combinations['combinations'];
    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('All Combinations'),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: combinations['combinations'].length,
          itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              color: Colors.blue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                contentPadding: EdgeInsets.all(10.0),
                onTap: (){
                  Navigator.pushNamed(context, '/code',arguments: {
                    'R1': arr[index].x,
                    'R2': arr[index].y,
                    'Tolerance':combinations['Tolerance'],
                    'value1':formatNum(arr[index].x),
                    'value2':formatNum(arr[index].y),
                    'orientation':getOrientation(arr[index].z)
                  });
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'R1: ',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),
                          ),
                          TextSpan(
                            text: '\n${formatNum(arr[index].x)}',
                            style: TextStyle(
                                color: Colors.amberAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),
                          )
                        ]
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'R2: ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                            ),
                            TextSpan(
                              text: '\n${formatNum(arr[index].y)}',
                              style: TextStyle(
                                  color: Colors.amberAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                            )
                          ]
                      ),
                    ),
                  ],
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(
                      Icons.chevron_right, color: Colors.white,
                      size: 35,
                    ),
                    Text(
                      '${getOrientation(arr[index].z)}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            )
          );
          }
      ),
    );
  }
}
