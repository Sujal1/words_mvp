import 'package:word_selector/repo/factory/repository.dart';
import 'package:word_selector/ui/common/starter_bloc.dart';
import 'package:word_selector/ui/word_list/usecase/word_list_presenter_model.dart';
import 'package:word_selector/ui/word_list/usecase/word_list_presenter_state.dart';
import 'package:word_selector/ui/word_list/usecase/word_list_use_case_output.dart';

class WordListUseCase with StarterBloc<WordListUseCaseOutput> {
  Repository _repository;

  WordListUseCase(this._repository) {
    streamAdd(PresentLoading());
    eventGenerateWordList();
  }

  void eventGenerateWordList() {
    _repository.generateWordList();
    _refreshDisplay();
  }

  void _refreshDisplay() {
    final presentModelRowList = _repository.shuffledWordList
        .map(
          (word) => PresenterRowModel(
            id: word.id,
            wordName: word.wordName,
            isWordSelected: _repository.isWordSelected(word.id),
          ),
        )
        .toList();
    streamAdd(
      PresentModel(
        PresenterModel(presentModelRowList),
        PresenterState(
          _repository.isInitialState,
          _repository.isGetMoreEnabled,
          _repository.isShowSelectionEnabled,
        ),
      ),
    );
  }

  void up() {
    _repository.shiftWordListDown();
    _refreshDisplay();
  }

  void down() {
    _repository.shiftWordListUp();
    _refreshDisplay();
  }

  void getMore() {
    _repository.toggleGetMore();
    _refreshDisplay();
  }

  void setSelection(int id) {
    _repository.setSelectedWord(id);
    _refreshDisplay();
  }
}
