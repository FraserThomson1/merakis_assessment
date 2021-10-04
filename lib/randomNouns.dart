import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:merakis_assessment_app/likedItemsStorage.dart';

class RandomNouns extends StatefulWidget {
  final likedItemsStorage storage = likedItemsStorage();
  _RandomNounsState createState() => _RandomNounsState();
}

class _RandomNounsState extends State<RandomNouns> {
  List _items = <String>[];
  List _likedItems = <String>[];

  void initState() {
    super.initState();
    widget.storage.readItems().then((List wps) {
      setState(() {
        _likedItems = wps;
      });
    });
  }

  Widget _buildList() {
    return ListView.builder(itemBuilder: (BuildContext _context, int i) {
      if (i % 2 == 1) {
        return Divider();
      }
      if (i >= _items.length) {
        generateWordPairs().take(10).forEach((element) {
          _items.add(element.asPascalCase);
        });
      }
      return _buildRow(_items[i]);
    });
  }

  Widget _buildRow(String wordPair) {
    bool liked = _likedItems.contains(wordPair);

    return ListTile(
      title: Text(wordPair),
      trailing: Icon(
        liked ? Icons.favorite : Icons.favorite_border,
        color: liked ? Colors.red : null,
      ),
      onTap: () async {
        if (liked) {
          _likedItems.remove(wordPair);
        } else {
          _likedItems.add(wordPair);
        }
        await widget.storage.writeItems(_likedItems);
        setState(() {});
      },
    );
  }

  Widget build(BuildContext context) {
    return _buildList();
  }
}
