import 'package:word_selector/ui/word_list/usecase/word_list_presenter_state.dart';

class ViewState {
  final bool initialState;
  final bool getMoreEnabled;
  final bool showSelection;

  ViewState.fromPresentation(PresenterState state)
      : initialState = state.initialState,
        getMoreEnabled = state.getMoreEnabled,
        showSelection = state.showSelection;
}
