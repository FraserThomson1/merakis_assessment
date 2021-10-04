import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merakis_assessment_app/homePage.dart';
import 'package:merakis_assessment_app/searchPage.dart';

// Handles the bottom navigation of the app
class NavigationPage extends StatefulWidget {
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _currentindex = 0; // Records which page to display
  List _pages = [
    HomePage(),
    SearchPage(),
  ];

  void updateView(int index) {
    setState(() {
      _currentindex = index; // Update displayed page
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentindex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentindex,
        onTap: updateView, // Update display index when bar touched
        items: [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.search), label: "Search")
        ],
      ),
    );
  }
}
