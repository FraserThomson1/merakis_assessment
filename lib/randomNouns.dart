import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomNouns extends StatefulWidget {
  _RandomNounsState createState() => _RandomNounsState();
}

class _RandomNounsState extends State<RandomNouns> {
  List _items = <WordPair>[];
  List _likedItems = <WordPair>[];

  Widget _buildList() {
    return ListView.builder(itemBuilder: (BuildContext _context, int i) {
      if (i % 2 == 1) {
        return Divider();
      }
      if (i >= _items.length) {
        _items.addAll(generateWordPairs().take(10));
      }
      return _buildRow(_items[i]);
    });
  }

  Widget _buildRow(WordPair wordPair) {
    bool liked = _likedItems.contains(wordPair);

    return ListTile(
      title: Text(wordPair.asPascalCase),
      trailing: Icon(
        liked ? Icons.favorite : Icons.favorite_border,
        color: liked ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (liked) {
            _likedItems.remove(wordPair);
          } else {
            _likedItems.add(wordPair);
          }
        });
      },
    );
  }

  Widget build(BuildContext context) {
    return _buildList();
  }
}
