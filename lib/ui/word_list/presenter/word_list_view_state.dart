import 'package:word_selector/ui/word_list/usecase/word_list_presenter_state.dart';

class ViewState {
  final bool upEnabled;
  final bool downEnabled;
  final bool getMoreEnabled;
  final bool showSelectionEnabled;
  final String selectedWord;

  ViewState.fromPresentation(PresenterState state)
      : upEnabled = state.upEnabled,
        downEnabled = state.downEnabled,
        getMoreEnabled = state.getMoreEnabled,
        showSelectionEnabled = state.showSelectionEnabled,
        selectedWord = state.selectedWord;
}
