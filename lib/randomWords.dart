import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:merakis_assessment_app/likedItemsStorage.dart';

class RandomWords extends StatefulWidget {
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  LikedItemsStorage _storage = LikedItemsStorage();
  List _items = <String>[]; // List of all items
  List _likedItems = <String>[]; // List of liked items

  void initState() {
    super.initState();
    _storage.readItems().then((List wps) {
      setState(() {
        _likedItems = wps; // Read list of liked items from storage
      });
    });
  }

  Widget _buildList() {
    return ListView.builder(itemBuilder: (BuildContext _context, int i) {
      if (i % 2 == 1) {
        return Divider();
      }
      // Add 10 more word pairs to list if reached bottom
      if (i >= _items.length) {
        generateWordPairs().take(10).forEach((element) {
          _items.add(element.asPascalCase); // Add String type to list
        });
      }
      return _buildRow(_items[i]); // Return Widget containing item
    });
  }

  Widget _buildRow(String wordPair) {
    // returns ListTile with wordPair and like button
    bool liked = _likedItems.contains(wordPair);

    return ListTile(
      title: Text(wordPair),
      trailing: Icon(
        // Change coloro of Icon based on state
        liked ? Icons.favorite : Icons.favorite_border,
        color: liked ? Colors.red : null,
      ),
      onTap: () async {
        // Update list of liked items
        if (liked) {
          _likedItems.remove(wordPair);
        } else {
          _likedItems.add(wordPair);
        }
        // Update stored list of liked items
        await _storage.writeItems(_likedItems);
        setState(() {}); // Update view
      },
    );
  }

  Widget build(BuildContext context) {
    return _buildList();
  }
}
