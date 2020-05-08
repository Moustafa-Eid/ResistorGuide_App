import 'package:flutter/material.dart';


class Instructions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Instructions'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'Welcome to the ResistorGuide App\nThank you for downloading!\nHere are the instructions for the app:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 50,),
              Text(
                'The 1st functionality for this app is to enter a color code of a resistor you are using and it will calculate and give you the resistance and tolerance of that resistor',
                textAlign: TextAlign.justify,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15
                ),
              ),
              SizedBox(height: 50,),
              Text(
                'The 2nd functionality for this app is both a resistor combinations calculator and a color code calculator. You enter a desired resistance and it will give you all the combinations of 2 standard resistors from a specific series that if combined in wither series or parallel, will give an equivalent resistance withing 2.5% of the desired value.\n\n You can then tap on each combination and it will display its color code, you can enter a standard resistance and also see the color code of it right away.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15
                ),
              ),
              SizedBox(height: 50,),
              Text(
                'If you enjoyed using my app and liked it, please consider leaving a review so it can help me improve my app.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.amberAccent,
                    fontSize: 15
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
