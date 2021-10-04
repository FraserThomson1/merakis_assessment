import 'package:flutter/material.dart';
import 'package:merakis_assessment_app/likedItemsStorage.dart';

class LikedItemsPage extends StatefulWidget {
  _LikedItemsPageState createState() => _LikedItemsPageState();
}

class _LikedItemsPageState extends State<LikedItemsPage> {
  final _storage = LikedItemsStorage(); // Used to access liked items
  List _likedItems = <String>[]; // Stored list of liked items
  bool _showItems = false; // Records whether items are being displayed or not

  void initState() {
    super.initState();
    _storage.readItems().then((List wps) {
      setState(() {
        _likedItems = wps; // Read list of liked items from storage
      });
    });
  }

  List<Widget> _buildList() {
    // Construct list of widgets using list of liked items
    List<Widget> widgets = <Widget>[];
    for (int i = 0; i < _likedItems.length; i++) {
      widgets.add(ListTile(
        title: Text(_likedItems[i]),
      ));
      widgets.add(Divider()); // Add Divider after each item
    }
    return widgets;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Fun Page"),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pop(context); // Navigate back to home when arrow pressed
          },
        ),
      ),
      body: Column(
        children: [
          GestureDetector(
              onTap: () {
                setState(() {
                  _showItems = !_showItems; // Toggle display of items
                });
              },
              child: Container(
                  color: Colors.grey[300],
                  child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(children: [
                        _showItems
                            ? Icon(Icons.arrow_drop_down)
                            : Icon(Icons
                                .arrow_drop_up), // Change arrow based on state of _showItems
                        Text(
                          "Liked items : " + _likedItems.length.toString(),
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ])))),
          _showItems
              ? Expanded(
                  child: ListView(
                    children: _buildList(), // Display list if _showItems true
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
