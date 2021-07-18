import 'package:word_selector/repo/factory/repository.dart';
import 'package:word_selector/ui/word_list/presenter/word_list_presenter.dart';
import 'package:word_selector/ui/word_list/router/word_list_router.dart';
import 'package:word_selector/ui/word_list/usecase/word_list_use_case.dart';
import 'package:word_selector/ui/word_list/view/word_list_scene.dart';

class WordListAssembly {
  final WordListScene scene;

  WordListAssembly._({this.scene});

  factory WordListAssembly(WordListRouter router) {
    final useCase = WordListUseCase(Repository.repo);
    final presenter = WordListPresenter(useCase, router);
    final scene = WordListScene(presenter);

    return WordListAssembly._(scene: scene);
  }
}
