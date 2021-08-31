import 'package:word_selector/ui/word_list/usecase/word_list_presenter_model.dart';

class ViewRowModel {
  final String wordName;
  final bool isWordSelected;

  ViewRowModel.fromPresentation(PresenterRowModel row)
      : wordName = row.wordName,
        isWordSelected = row.selected;
}

class ViewModel {
  final List<ViewRowModel> rows;
  ViewModel.fromPresentation(PresenterModel model)
      : rows = model.rows
            .map((row) => ViewRowModel.fromPresentation(row))
            .toList();
}