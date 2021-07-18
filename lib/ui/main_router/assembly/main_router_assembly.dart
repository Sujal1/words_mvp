import 'package:word_selector/repo/factory/repository.dart';
import 'package:word_selector/ui/main_router/presenter/main_router_presenter.dart';
import 'package:word_selector/ui/main_router/use_case/main_router_use_case.dart';
import 'package:word_selector/ui/main_router/view/main_router_scene.dart';
import 'package:flutter/material.dart';

class MainRouterAssembly {
  final MainRouterScene scene;
  MainRouterAssembly._({@required this.scene});

  factory MainRouterAssembly() {
    final useCase = MainRouterUseCase(Repository.repo);
    final presenter = MainRouterPresenter(useCase);
    final scene = MainRouterScene(presenter);
    return MainRouterAssembly._(scene: scene);
  }
}
