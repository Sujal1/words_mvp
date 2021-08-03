import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:word_selector/ui/common/constants.dart';

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

  List<WordEntity> visibleWordList;

  WordEntity _selectedWord;

  bool _getMoreButtonTapped = false;

  bool get isUpEnabled => visibleWordList.first.id != _wordList.first.id;

  bool get isDownEnabled {
    return _getMoreButtonTapped
        ? true
        : visibleWordList.last.id != _wordList.last.id;
  }

  bool get isGetMoreEnabled {
    return _getMoreButtonTapped
        ? false
        : visibleWordList.last.id == _wordList.last.id;
  }

  bool get isShowSelectionEnabled => _selectedWord != null;

  String get selectedWord =>
      _selectedWord != null ? _selectedWord.wordName : '';

  Repository._();

  void generateWordList() {
    _wordList.clear();

    _wordList.add(WordEntity(id: 1, wordName: 'Aligator'));
    _wordList.add(WordEntity(id: 2, wordName: 'Baboon'));
    _wordList.add(WordEntity(id: 3, wordName: 'Cat'));
    _wordList.add(WordEntity(id: 4, wordName: 'Dinosaur'));
    _wordList.add(WordEntity(id: 5, wordName: 'Eagle'));
    _wordList.add(WordEntity(id: 6, wordName: 'Fish'));
    _wordList.add(WordEntity(id: 7, wordName: 'Goat'));
    _wordList.add(WordEntity(id: 8, wordName: 'Hen'));
    _wordList.add(WordEntity(id: 9, wordName: 'Iguana'));
    _wordList.add(WordEntity(id: 10, wordName: 'Jackal'));
    _wordList.add(WordEntity(id: 11, wordName: 'Kangaroo'));
    _wordList.add(WordEntity(id: 12, wordName: 'Lion'));
    _wordList.add(WordEntity(id: 13, wordName: 'Monkey'));
    _wordList.add(WordEntity(id: 14, wordName: 'Nightingale'));
    _wordList.add(WordEntity(id: 15, wordName: 'Orangutan'));
    _wordList.add(WordEntity(id: 16, wordName: 'Pig'));
    _wordList.add(WordEntity(id: 17, wordName: 'Quail'));
    _wordList.add(WordEntity(id: 18, wordName: 'Rooster'));
    _wordList.add(WordEntity(id: 19, wordName: 'Snake'));
    _wordList.add(WordEntity(id: 20, wordName: 'Tiger'));

    visibleWordList = _wordList.sublist(0, VISIBLE_WORDS_COUNT);
  }

  void setGetMoreButtonTapped() {
    _getMoreButtonTapped = true;
  }

  void resetGetMoreButtonTapped() {
    _getMoreButtonTapped = false;
  }

  void shiftWordListDown() {
    int index = _wordList.indexOf(visibleWordList.first);

    if (index - 1 + VISIBLE_WORDS_COUNT < _wordList.length) {
      visibleWordList =
          _wordList.sublist(index - 1, index - 1 + VISIBLE_WORDS_COUNT);
    } else {
      visibleWordList = _wordList.sublist(index - 1);
      int numberOfAdditionalVisibleWords =
          VISIBLE_WORDS_COUNT - visibleWordList.length;
      visibleWordList
          .addAll(_wordList.sublist(0, numberOfAdditionalVisibleWords));
    }
  }

  void shiftWordListUp() {
    int index = _wordList.indexOf(visibleWordList.first);
    if (index + 1 + VISIBLE_WORDS_COUNT < _wordList.length) {
      visibleWordList =
          _wordList.sublist(index + 1, index + 1 + VISIBLE_WORDS_COUNT);
    } else {
      visibleWordList = _wordList.sublist(index + 1);
      int numberOfAdditionalVisibleWords =
          VISIBLE_WORDS_COUNT - visibleWordList.length;
      visibleWordList
          .addAll(_wordList.sublist(0, numberOfAdditionalVisibleWords));
    }
  }

  void setSelectedWord(int id) {
    _selectedWord = _wordList.firstWhere((word) => word.id == id);
  }

  bool isWordSelected(int id) {
    return _selectedWord != null ? _selectedWord.id == id : false;
  }
}
