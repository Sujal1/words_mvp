import 'package:word_selector/ui/word_list/usecase/word_list_presenter_model.dart';

abstract class WordListUseCaseOutput {}

class PresentModel extends WordListUseCaseOutput {
  final PresenterModel model;

  PresentModel(this.model);
}

class PresentLoading extends WordListUseCaseOutput {}
