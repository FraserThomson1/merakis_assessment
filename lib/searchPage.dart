import 'package:flutter/material.dart';
import 'package:merakis_assessment_app/likedItemsStorage.dart';

class SearchPage extends StatefulWidget {
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _storage = LikedItemsStorage();
  final _textController = TextEditingController();
  List _displayedItems = <String>[];
  List _likedItems = <String>[];

  void initState() {
    super.initState();
    _storage.readItems().then((List wps) {
      setState(() {
        _likedItems = wps;
      });
    });
  }

  List<String> _searchItem(String item) {
    List<String> results = [];
    for (final i in _likedItems) {
      if (i.contains(RegExp(item, caseSensitive: false))) {
        results.add(i);
      }
    }
    return results;
  }

  List<Widget> _buildList() {
    List<Widget> widgets = <Widget>[];
    for (int i = 0; i < _displayedItems.length; i++) {
      widgets.add(ListTile(
        title: Text(_displayedItems[i]),
      ));
      widgets.add(Divider());
    }
    return widgets;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search Page"), centerTitle: true),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                  padding: EdgeInsets.all(5.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _displayedItems = _searchItem(_textController.text);
                      });
                    },
                    child: Text("Search"),
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                  )),
              Expanded(
                  child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                    hintText: "Input liked item to search for..."),
              ))
            ],
          ),
          Expanded(child: ListView(children: _buildList()))
        ],
      ),
    );
  }
}
