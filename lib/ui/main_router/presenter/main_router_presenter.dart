import 'package:word_selector/ui/common/starter_bloc.dart';
import 'package:word_selector/ui/main_router/presenter/main_router_presenter_output.dart';
import 'package:word_selector/ui/main_router/use_case/main_router_use_case.dart';
import 'package:word_selector/ui/word_list/router/word_list_router.dart';

class MainRouterPresenter with StarterBloc<MainRouterPresenterOutput> implements WordListRouter {

  final MainRouterUseCase _useCase;
  MainRouterPresenter(this._useCase);
  
}