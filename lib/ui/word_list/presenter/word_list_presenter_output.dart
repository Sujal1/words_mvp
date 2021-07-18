import 'package:word_selector/ui/word_list/presenter/word_list_view_model.dart';
import 'package:word_selector/ui/word_list/presenter/word_list_view_state.dart';

abstract class WordListPresenterOutput {}

class ShowModel extends WordListPresenterOutput {
  final ViewModel model;
  final ViewState state;

  ShowModel(
    this.model,
    this.state,
  );
}

class ShowLoading extends WordListPresenterOutput {}
