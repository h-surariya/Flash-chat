import 'package:flutter/material.dart';
class RoundedButton extends StatelessWidget {
  final Color color;
  final String text;
  final Function navigate;

  const RoundedButton({this.color, this.text, @required this.navigate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: navigate,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            text,
            style: TextStyle(color: Colors.white,),
          ),
        ),
      ),
    );
  }
}