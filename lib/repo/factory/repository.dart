import 'package:english_words/english_words.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WordEntity {
  final int id;
  final String wordName;

  WordEntity({
    @required this.id,
    @required this.wordName,
  });
}

class Repository {
  static final repo = Repository._();

  final List<WordEntity> _words = <WordEntity>[];

  Repository._();

  List<WordEntity> get wordList => _words;

  void generateWordList() {
    print('-----');
    final count = _words.length;
    final pairs = generateWordPairs()
        .take(10)
        .map((pair) => pair.asPascalCase)
        .toList()
        .asMap()
        .entries
        .map((entry) =>
            WordEntity(id: entry.key + count, wordName: entry.value));
    _words.addAll(pairs);
    _words.forEach((element) {print('${element.id}: ${element.wordName}');});
  }
}
