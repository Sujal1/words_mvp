import 'package:word_selector/ui/common/starter_bloc.dart';
import 'package:word_selector/ui/word_list/presenter/word_list_presenter_output.dart';
import 'package:word_selector/ui/word_list/presenter/word_list_view_model.dart';
import 'package:word_selector/ui/word_list/router/word_list_router.dart';
import 'package:word_selector/ui/word_list/usecase/word_list_presenter_model.dart';
import 'package:word_selector/ui/word_list/usecase/word_list_use_case.dart';
import 'package:word_selector/ui/word_list/usecase/word_list_use_case_output.dart';

class WordListPresenter with StarterBloc<WordListPresenterOutput> {
  final WordListUseCase _useCase;
  final WordListRouter _router;

  PresenterModel _cachedPresenterModel;

  bool get down =>
      _cachedPresenterModel.rows.last.id != _cachedPresenterModel.lastId;

  bool get up =>
      _cachedPresenterModel.rows.first.id != _cachedPresenterModel.firstId;

  bool get getMore =>
      _cachedPresenterModel.rows.last.id == _cachedPresenterModel.lastId;

  bool get showSelection => _cachedPresenterModel.selectedWord != null;

  String get selectedWord => _cachedPresenterModel.selectedWord;
  
  WordListPresenter(this._useCase, this._router) {
    _useCase.stream.listen((event) {
      if (event is PresentLoading) {
        streamAdd(ShowLoading());
      } else if (event is PresentModel) {
        _cachedPresenterModel = event.model;
        streamAdd(
          ShowModel(
            ViewModel.fromPresentation(event.model),
          ),
        );
      } else {
        assert(false, 'unknown event: $event');
        return null;
      }
    });
  }

  void moveListUp() {
    _useCase.moveListUp();
  }

  void moveListDown() {
    _useCase.moveListDown();
  }

  void getMoreWords() {
    _useCase.getMoreWords();
  }

  void setSelectedWord(int index) {
    _useCase.setSelectedWord(_cachedPresenterModel.rows[index].id);
  }
}
