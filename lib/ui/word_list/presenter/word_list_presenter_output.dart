import 'package:word_selector/ui/word_list/presenter/word_list_view_model.dart';

abstract class WordListPresenterOutput {}

class ShowModel extends WordListPresenterOutput {
  final ViewModel model;

  ShowModel(
    this.model,
  );
}

class ShowLoading extends WordListPresenterOutput {}
