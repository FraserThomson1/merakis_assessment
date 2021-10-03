import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merakis_assessment_app/likedItemsPage.dart';
import 'package:merakis_assessment_app/homePage.dart';

class NavigationPage extends StatefulWidget {
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _currentindex = 0;
  List _pages = [
    HomePage(),
    LikedItemsPage(),
  ];

  void updateView(int index) {
    setState(() {
      _currentindex = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentindex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentindex,
        onTap: updateView,
        items: [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.heart), label: "Liked Items")
        ],
      ),
    );
  }
}