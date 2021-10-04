import 'package:flutter/material.dart';
import 'package:merakis_assessment_app/likedItemsStorage.dart';

class LikedItemsPage extends StatefulWidget {
  final storage = likedItemsStorage();
  _LikedItemsPageState createState() => _LikedItemsPageState();
}

class _LikedItemsPageState extends State<LikedItemsPage> {
  List _likedItems = <String>[];
  bool _showItems = false;

  void initState() {
    super.initState();
    widget.storage.readItems().then((List wps) {
      setState(() {
        _likedItems = wps;
      });
    });
  }

  List<Widget> _buildList() {
    List<Widget> widgets = <Widget>[];
    for (int i = 0; i < _likedItems.length; i++) {
      widgets.add(ListTile(
        title: Text(_likedItems[i]),
      ));
      widgets.add(Divider());
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
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
              onTap: () {
                setState(() {
                  _showItems = !_showItems;
                });
              },
              child: Container(
                  color: Colors.grey[300],
                  child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(children: [
                        _showItems
                            ? Icon(Icons.arrow_drop_down)
                            : Icon(Icons.arrow_drop_up),
                        Text(
                          "Liked items : " + _likedItems.length.toString(),
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ])))),
          _showItems
              ? Expanded(
                  child: ListView(
                    children: _buildList(),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
