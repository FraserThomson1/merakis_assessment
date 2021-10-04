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

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

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
    return item == "" ? [] : results;
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
      appBar: AppBar(title: Text("Search"), centerTitle: true),
      body: Column(
        children: [
          Container(
              color: Colors.white,
              child: Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 5.0, top: 5.0),
                      child: Container(
                          height: 40.0,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _displayedItems =
                                    _searchItem(_textController.text);
                              });
                            },
                            child: Text("Search"),
                            style:
                                ElevatedButton.styleFrom(primary: Colors.blue),
                          ))),
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.only(right: 5.0, top: 5.0),
                          child: Container(
                              height: 40.0,
                              child: TextField(
                                controller: _textController,
                                decoration: InputDecoration(
                                    fillColor: Colors.grey[300],
                                    filled: true,
                                    hintText: "Search from liked items..."),
                              ))))
                ],
              )),
          Expanded(
              child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: _displayedItems.length == 0
                      ? Center(
                          child: Text(
                          "0 results",
                          style: TextStyle(color: Colors.grey),
                        ))
                      : ListView(children: _buildList())))
        ],
      ),
    );
  }
}
