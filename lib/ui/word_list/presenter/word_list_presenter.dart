import 'package:word_selector/ui/common/starter_bloc.dart';
import 'package:word_selector/ui/word_list/presenter/word_list_presenter_output.dart';
import 'package:word_selector/ui/word_list/presenter/word_list_view_model.dart';
import 'package:word_selector/ui/word_list/presenter/word_list_view_state.dart';
import 'package:word_selector/ui/word_list/router/word_list_router.dart';
import 'package:word_selector/ui/word_list/usecase/word_list_presenter_model.dart';
import 'package:word_selector/ui/word_list/usecase/word_list_use_case.dart';
import 'package:word_selector/ui/word_list/usecase/word_list_use_case_output.dart';

class WordListPresenter with StarterBloc<WordListPresenterOutput> {
  final WordListUseCase _useCase;
  final WordListRouter _router;

  PresenterModel _cachedPresenterModel;

  WordListPresenter(this._useCase, this._router) {
    _useCase.stream.listen((event) {
      if (event is PresentLoading) {
        streamAdd(ShowLoading());
      } else if (event is PresentModel) {
        _cachedPresenterModel = event.model;
        streamAdd(
          ShowModel(
            ViewModel.fromPresentation(event.model),
            ViewState.fromPresentation(event.state),
          ),
        );
      } else {
        assert(false, 'unknown event: $event');
        return null;
      }
    });
  }

  void up() {
    _useCase.up();
  }

  void down() {
    _useCase.down();
  }

  void getMore() {
    _useCase.getMore();
  }

  void setSelection(int index) {
    final id = _cachedPresenterModel.rows[index].id;
    _useCase.setSelection(id);
  }

  String getSelectedWord() {
    PresenterRowModel selectedRow = _cachedPresenterModel.rows.firstWhere((element) => element.isWordSelected);
    return selectedRow.wordName;
  }
}
