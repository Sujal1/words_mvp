import 'package:flutter/material.dart';
import 'package:word_selector/ui/common/bloc_provider.dart';
import 'package:word_selector/ui/main_router/presenter/main_router_presenter.dart';
import 'package:word_selector/ui/word_list/assembly/word_list_assembly.dart';

class MainRouterScene extends StatelessWidget {
  final MainRouterPresenter _presenter;
  final navKey = GlobalKey<NavigatorState>();

  MainRouterScene(this._presenter) {
    _presenter.stream.listen((event) {
      
    });
  }

  static const routeNameRoot = "/";

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainRouterPresenter>(
      bloc: _presenter,
      child: Navigator(
        key: navKey,
        initialRoute: routeNameRoot,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case routeNameRoot:
              builder = (BuildContext context) {
                return WordListAssembly(_presenter).scene;
              };
              break;
            default:
              break;
          }

          return MaterialPageRoute(builder: builder, settings: settings);
        },
      ),
    );
  }
}
