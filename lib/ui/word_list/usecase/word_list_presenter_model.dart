import 'package:flutter/foundation.dart';

class PresenterRowModel {
  final int id;
  final String wordName;
  final bool isWordSelected;

  PresenterRowModel({
    @required this.id,
    @required this.wordName,
    @required this.isWordSelected,
  });
}

class PresenterModel {
  final List<PresenterRowModel> rows;
  PresenterModel(this.rows);
}