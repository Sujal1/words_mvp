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

  final List<WordEntity> _wordList = <WordEntity>[];

  final List<WordEntity> _shuffledWordList = <WordEntity>[];

  final List<WordEntity> _tempWordList = <WordEntity>[];

  int _selectedId;

  bool _getMoreEnabled = true;

  bool get isGetMoreEnabled => _getMoreEnabled;

  bool get isShowSelectionEnabled => _selectedId != null;

  bool get isInitialState => _wordList.first.id == _shuffledWordList.first.id;

  Repository._();

  List<WordEntity> get shuffledWordList => _shuffledWordList;

  void generateWordList() {
    print('----');
    _wordList.clear();
    _shuffledWordList.clear();

    _wordList.add(WordEntity(id: 1, wordName: 'WordPlay'));
    _wordList.add(WordEntity(id: 2, wordName: 'QuickDraw'));
    _wordList.add(WordEntity(id: 3, wordName: 'NewWorld'));
    _wordList.add(WordEntity(id: 4, wordName: 'MondoCondo'));
    _wordList.add(WordEntity(id: 5, wordName: 'BresselsSprout'));

    _shuffledWordList.addAll(_wordList);
  }

  void setSelectedWord(int id) {
    _selectedId = id;
  }

  bool isWordSelected(int id) {
    return id == _selectedId;
  }

  void toggleGetMore() {
    _getMoreEnabled = !_getMoreEnabled;
  }

  void shiftWordListDown() {
    _selectedId = null;

    _tempWordList.addAll(_shuffledWordList);

    for (int i = 0; i < _tempWordList.length; i++) {
      if ((i + 1) == _tempWordList.length) {
        _shuffledWordList[0] = _tempWordList[i];
      } else {
        _shuffledWordList[i + 1] = _tempWordList[i];
      }
    }

    if (isInitialState) {
      _getMoreEnabled = true;
    }

    _tempWordList.clear();
  }

  void shiftWordListUp() {
    _selectedId = null;

    _tempWordList.addAll(_shuffledWordList);

    for (int i = 0; i < _tempWordList.length; i++) {
      if (i == 0) {
        _shuffledWordList[_shuffledWordList.length - 1] = _tempWordList[0];
      } else {
        _shuffledWordList[i - 1] = _tempWordList[i];
      }
    }

    if (isInitialState) {
      _getMoreEnabled = true;
    }

    _tempWordList.clear();
  }
}
