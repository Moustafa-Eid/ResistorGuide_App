import 'package:flutter/material.dart';

class Choose extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.topRight,
              child: IconButton(
                padding: EdgeInsets.all(10.0),
                onPressed: () {
                  Navigator.pushNamed(context, '/info');
                },
                icon: Icon(Icons.info_outline),
                iconSize: 35,
                color: Colors.blue,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    'Resistor Guide',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3.0,
                        color: Colors.white
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/2,
                    height: MediaQuery.of(context).size.height/6,
                    child: RaisedButton(
                      onPressed: (){
                        Navigator.pushNamed(context, '/colortoRes');
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.white)
                      ),
                      child: Text(
                          'Find Resistance Given Color Code',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/2,
                    height: MediaQuery.of(context).size.height/6,
                    child: RaisedButton(
                      onPressed: (){
                        Navigator.pushNamed(context, '/');
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.white)
                      ),
                      child: Text(
                        'Find Resistor Combinations & Color Code Given Resistance',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
