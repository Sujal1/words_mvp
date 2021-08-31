import 'package:flutter/foundation.dart';

class PresenterRowModel {
  final int id;
  final String wordName;
  final bool selected;

  PresenterRowModel({
    @required this.id,
    @required this.wordName,
    @required this.selected,
  });
}

class PresenterModel {
  final List<PresenterRowModel> rows;
  final int firstId;
  final int lastId;
  final String selectedWord;
  PresenterModel(
    this.rows,
    this.firstId,
    this.lastId,
    this.selectedWord,
  );
}
