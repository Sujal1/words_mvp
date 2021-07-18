import 'package:word_selector/ui/word_list/usecase/word_list_presenter_model.dart';
import 'package:word_selector/ui/word_list/usecase/word_list_presenter_state.dart';

abstract class WordListUseCaseOutput {}

class PresentModel extends WordListUseCaseOutput {
  final PresenterModel model;
  final PresenterState state;
  PresentModel(this.model, this.state);
}

class PresentLoading extends WordListUseCaseOutput {}
