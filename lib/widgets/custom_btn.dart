import 'package:flutter/material.dart';

//widget for buttons
class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool outLineButton;
  final bool isLoading;

  const CustomButton(
      {Key key, this.text, this.onPressed, this.outLineButton, this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _outlineBtn = outLineButton ?? false;
    bool _isLoading = isLoading ?? false;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60.0,
        decoration: BoxDecoration(
            color: _outlineBtn ? Colors.transparent : Colors.black,
            border: Border.all(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Stack(children: [
          Visibility(
            visible: _isLoading ? false : true,
            child: Center(
              child: Text(
                text ?? 'text',
                style: TextStyle(
                    fontSize: 16,
                    color: _outlineBtn ? Colors.black : Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Visibility(
            visible: _isLoading,
                      child: Center(
                child: SizedBox(
                    height: 30, width: 30, child: CircularProgressIndicator())),
          )
        ]),
      ),
    );
  }
}
