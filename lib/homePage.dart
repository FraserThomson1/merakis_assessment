import 'package:flutter/material.dart';
import 'package:merakis_assessment_app/likedItemsPage.dart';
import 'randomNouns.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void navigateToLikedItems() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LikedItemsPage()));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home"),
        actions: [
          GestureDetector(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite),
                Text("Liked Items"),
              ],
            ),
            onTap: navigateToLikedItems,
          )
        ],
      ),
      body: RandomNouns(),
    );
  }
}
