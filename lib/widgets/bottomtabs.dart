import 'package:flutter/material.dart';

class BottomTabs extends StatefulWidget {
  final int tabSelected;
  final Function(int) pressedTab;

  const BottomTabs({Key key, this.tabSelected, this.pressedTab})
      : super(key: key);
  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    selectedTab = widget.tabSelected ?? 0;

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.06),
                spreadRadius: 1.0,
                blurRadius: 30.0)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomTabButton(
              selected: selectedTab == 0 ? true : false,
              onPressed: () {
                widget.pressedTab(0);
              }),
          BottomTabButton(
            imagePath: 'assets/images/tab_search.png',
            selected: selectedTab == 1 ? true : false,
            onPressed: () {
              widget.pressedTab(1);
            },
          ),
          BottomTabButton(
            imagePath: 'assets/images/tab_saved.png',
            selected: selectedTab == 2 ? true : false,
            onPressed: () {
              widget.pressedTab(2);
            },
          ),
          BottomTabButton(
            imagePath: 'assets/images/tab_logout.png',
            onPressed: () {
              widget.pressedTab(3);
            },
          )
        ],
      ),
    );
  }
}

class BottomTabButton extends StatelessWidget {
  final String imagePath;
  final bool selected;
  final Function onPressed;
  BottomTabButton({this.imagePath, this.selected, this.onPressed});

  @override
  Widget build(BuildContext context) {
    bool _selected = selected ?? false;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
                      color: _selected
                          ? Theme.of(context).accentColor
                          : Colors.transparent,
                      width: 2.0))),
          padding: EdgeInsets.symmetric(vertical: 28, horizontal: 16),
          child: Image(
              color: _selected ? Theme.of(context).accentColor : Colors.black,
              width: 22,
              height: 22,
              image: AssetImage(imagePath ?? 'assets/images/tab_home.png'))),
    );
  }
}
