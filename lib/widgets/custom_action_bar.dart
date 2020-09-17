import 'package:ecommerce/constants.dart';
import 'package:flutter/material.dart';

class ActionBar extends StatelessWidget {
  final String title;
  final bool backArrow;
  final bool hasTitle;
  final bool hasBackground;
  const ActionBar(
      {Key key, this.title, this.backArrow, this.hasTitle, this.hasBackground})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _backArrow = backArrow ?? false;
    bool _hasTitle = hasTitle ?? true;
    bool _hasBackground = hasBackground ?? true;

    return Container(
      decoration: BoxDecoration(
          gradient: _hasBackground
              ? LinearGradient(
                  colors: [Colors.white, Colors.white.withOpacity(0)],
                  begin: Alignment(0, 0),
                  end: Alignment(0, 1))
              : null),
      padding: EdgeInsets.only(top: 56, right: 24, left: 24, bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_backArrow)
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12)),
                  alignment: Alignment.center,
                  child: Image(
                    width: 16,
                    height: 16,
                    image: AssetImage('assets/images/back_arrow.png'),
                    color: Colors.white,
                  )),
            ),
          if (_hasTitle)
            Text(
              title ?? 'Action Bar',
              style: Constants.boldHeading,
            ),
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(12)),
            alignment: Alignment.center,
            child: Text('0',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w600)),
          )
        ],
      ),
    );
  }
}
