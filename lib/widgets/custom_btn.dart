import 'package:flutter/material.dart';

//widget for buttons
class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool outLineButton;

  const CustomButton({Key key, this.text, this.onPressed, this.outLineButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _outlineBtn = outLineButton ?? false;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        
        height: 60.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _outlineBtn ? Colors.transparent : Colors.black,
            border: Border.all(
                color:  Colors.black,
                width: 2.0),
            borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Text(
          text ?? 'text',
          style: TextStyle(
              fontSize: 16,
              color: _outlineBtn ? Colors.black : Colors.white,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
