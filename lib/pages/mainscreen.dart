import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class Units {
  String name;
  double multiplier;
  Units(this.name,this.multiplier);

  static List<Units> getUnits() {
    return <Units>[
      Units('Ω', 1),
      Units('kΩ', 1000),
      Units('MΩ', 1000000),
    ];
  }

}

class RTypes {
  String name;
  double tolerance;
  String url;
  double max;
  RTypes(this.name,this.tolerance,this.url,this.max);

  static List<RTypes> getRTypes() {
    return <RTypes>[
      RTypes('E3 - Tolerance: 40%', 40.0,'Sets/E3.txt',4.7),
      RTypes('E6 - Tolerance: 20%', 20.0,'Sets/E6.txt',6.8),
      RTypes('E12 - Tolerance: 10%', 10.0,'Sets/E12.txt',8.2),
      RTypes('E24 - Tolerance: 5%', 5.0,'Sets/E24.txt',9.1),
      RTypes('E48 - Tolerance: 2%', 2.0,'Sets/E48.txt',9.53),
      RTypes('E96 - Tolerance: 1%', 1.0,'Sets/E96.txt',9.76),
      RTypes('E192 - Tolerance: 0.5%', 0.5,'Sets/E192.txt',9.88),
    ];
  }

}


class _HomeState extends State<Home> {

  List<Units> _units = Units.getUnits();
  List<RTypes> _RTypes = RTypes.getRTypes();
  List<DropdownMenuItem<RTypes>> _dropdownMenuItems2;
  Units _selectedUnit;
  RTypes _selectedType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedUnit = _units[0];
    _dropdownMenuItems2 = buildDropdownMenuItems2(_RTypes);
    _selectedType = _dropdownMenuItems2[0].value;
  }

  // Builds Drop down menu for tolerance of resistor
  List<DropdownMenuItem<RTypes>> buildDropdownMenuItems2(List rtypes) {
    List<DropdownMenuItem<RTypes>> items = List();
    for (RTypes rtype in rtypes) {
      items.add(
        DropdownMenuItem(
          value: rtype,
          child: Text(
              rtype.name
          ),
        ),
      );
    }
    return items;
  }

  // Alert Dialog to catch edge cases and errors
  Future<void> _Alert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Illegal Input'),
          content: const Text('This resistance cannot be created using only 2 resistors of this series.\n\nPlease enter a different resistance value.'),
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



  TextEditingController _controller = new TextEditingController();
  String res;

  Widget body() {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: FlatButton.icon(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/main');
            },
            color: Colors.transparent,
            icon: Icon(
              Icons.chevron_left,
              color: Colors.white,
              size: 25,
            ),
            label: Text(
              'Main Menu',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "Resistance",
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3.0,
                      color: Colors.white
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: TextField(
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                            ),
                            controller: _controller,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              suffixText: _selectedUnit.name,
                              suffixStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25
                              ),
                              filled: true,
                              fillColor: Colors.grey[300],
                              border: OutlineInputBorder(),
                              hintText: 'Desired Resistance:',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  "Units",
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3.0,
                      color: Colors.white
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,8.0,0,0),
                  child: CustomRadioButton(
                    elevation: 5.0,
                    buttonColor: Colors.grey[300],
                    buttonLables: [
                      "Ω",
                      "kΩ",
                      "MΩ",
                    ],
                    buttonValues: _units,
                    enableShape: true,
                    customShape: StadiumBorder(),
                    radioButtonValue: (selectedUnit) {
                      FocusScopeNode currentFocus = FocusScope.of(context);

                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      setState(() {
                        _selectedUnit = selectedUnit;
                      });
                    },
                    selectedColor: Colors.blue,
                    hight: 50,
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  "Tolerance",
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3.0,
                      color: Colors.white
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(MdiIcons.formatListBulletedType),
                        Flexible(
                          child: Container(
                            child: DropdownButton(
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Colors.black87,
                              ),
                              value: _selectedType,
                              items: _dropdownMenuItems2,
                              hint: Text('Resistor Type:'),
                              onChanged: (RTypes selectedType) {
                                setState(() {
                                  _selectedType = selectedType;
                                });
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Hero(
              tag: 'dash',
              child: ButtonTheme(
                minWidth: 250.0,
                height: 70.0,
                child: RaisedButton.icon(
                  onPressed: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    if(_controller.text == '' || double.tryParse(_controller.text) == null || (double.parse((_controller.text))*_selectedUnit.multiplier) > ((_selectedType.max*2) *1000000) || (double.parse((_controller.text))*_selectedUnit.multiplier) < 0.5) {
                      _Alert(context);
                    }
                    else {
                      Navigator.pushNamed(context, '/load', arguments: {
                        'Resistance': double.parse((_controller.text)),
                        'Multiplier': _selectedUnit.multiplier,
                        'Tolerance': _selectedType.tolerance,
                        'Url': _selectedType.url,
                      });
                    }
                  },
                  icon: Icon(MdiIcons.calculator,size: 35.0,color: Colors.white,),
                  label: Text(
                    'Load Combinations',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),
                  color: Colors.blue,
                  shape: StadiumBorder(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.blueGrey[700],
        body: SafeArea(
          child: OrientationBuilder(
            builder: (context, orientation) {
              if(orientation == Orientation.portrait) {
                return body();
              }
              else {
                return SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: body(),
                );
              }
            }
          ),
        ),
      ),
    );
  }
}
