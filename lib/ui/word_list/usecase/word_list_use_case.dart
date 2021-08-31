import 'package:word_selector/repo/factory/repository.dart';
import 'package:word_selector/ui/common/starter_bloc.dart';
import 'package:word_selector/ui/word_list/usecase/word_list_presenter_model.dart';
import 'package:word_selector/ui/word_list/usecase/word_list_use_case_output.dart';

class WordListUseCase with StarterBloc<WordListUseCaseOutput> {
  Repository _repository;

  List<WordEntity> _cachedWordList;

  int _startIndex = 0;

  int _selectedId;
  String _selectedWord;

  WordListUseCase(this._repository) {
    streamAdd(PresentLoading());
    eventGenerateWordList();
  }

  void eventGenerateWordList() {
    _repository.generateWordList();
    _cachedWordList = _repository.wordList;
    _refreshDisplay();
  }

  void _refreshDisplay() {
    final presentModelRowList = _cachedWordList
        .sublist(_startIndex, _startIndex + 5)
        .map(
          (word) => PresenterRowModel(
            id: word.id,
            wordName: word.wordName,
            selected: _selectedId != null && _selectedId == word.id,
          ),
        )
        .toList();

    streamAdd(
      PresentModel(
        PresenterModel(
          presentModelRowList,
          _cachedWordList.first.id,
          _cachedWordList.last.id,
          _selectedWord,
        ),
      ),
    );
  }

  void moveListUp() {
    _startIndex += 1;
    _refreshDisplay();
  }

  void moveListDown() {
    _startIndex -= 1;
    _refreshDisplay();
  }

  void getMoreWords() {
    eventGenerateWordList();
  }

  void setSelectedWord(int id) {
    _selectedId = id;
    _selectedWord =
        _cachedWordList.firstWhere((word) => word.id == id).wordName;
    _refreshDisplay();
  }
}
