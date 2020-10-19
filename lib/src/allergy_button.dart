import 'package:flutter/material.dart';

class AllergyButton extends StatefulWidget {
  @override
  _AllergyButtonState createState() => _AllergyButtonState();
}

class _AllergyButtonState extends State<AllergyButton> {
  bool _isVisible = true;

  void _toggle() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        RaisedButton(
          shape: CircleBorder(side: BorderSide(width: 0.5)),
          child: Text(
            '👁',
            style: TextStyle(fontSize: 20.0),
          ),
          onPressed: _toggle,
        ),
        Text(
          'Allergens',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
      ]),
      Row(children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(
            90.0,
            0.0,
            0.0,
            12.0,
          ),
          alignment: Alignment.centerLeft,
          child: Visibility(
            child: Text('Lactose'),
            visible: _isVisible,
          ),
        ),
      ]),
      Container(
        padding: EdgeInsets.fromLTRB(
          12.0,
          8.0,
          0.0,
          0.0,
        ),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1.0)),
        ),
      ),
    ]);
  }
}
