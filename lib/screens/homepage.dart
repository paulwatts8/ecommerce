import 'package:ecommerce/widgets/bottomtabs.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _tabPageController;
  int _selectedTab = 0;

  @override
  void initState() {
    _tabPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Expanded(
              child: PageView(
                controller: _tabPageController,
                onPageChanged: (num) {
                  setState(() {
                    _selectedTab = num;
                  });
                },
                children: [
                  Container(child: Center(child: Text('Homepage'))),
                  Container(child: Center(child: Text('search'))),
                  Container(child: Center(child: Text('saved'))),
                ],
              ),
            ),
          ),
          BottomTabs(
              tabSelected: _selectedTab,
              pressedTab: (num) {
                setState(() {
                  _tabPageController.animateToPage(num,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeOutCubic);
                });
              })
        ],
      ),
    );
  }
}
