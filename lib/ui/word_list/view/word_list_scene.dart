import 'package:flutter/material.dart';
import 'package:word_selector/ui/common/bloc_builder.dart';
import 'package:word_selector/ui/common/bloc_provider.dart';
import 'package:word_selector/ui/word_list/presenter/word_list_presenter.dart';
import 'package:word_selector/ui/word_list/presenter/word_list_presenter_output.dart';
import 'package:word_selector/ui/word_list/presenter/word_list_view_model.dart';
import 'package:word_selector/ui/word_list/presenter/word_list_view_state.dart';

class WordListScene extends StatelessWidget {
  final WordListPresenter _presenter;

  WordListScene(this._presenter);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordListPresenter, WordListPresenterOutput>(
      bloc: _presenter,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        final data = snapshot.data;
        if (data is ShowLoading) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (data is ShowModel) {
          final viewModel = data.model;
          final viewState = data.state;
          return Scaffold(
            appBar: AppBar(
              title: Text('Word List (${viewModel.rows.length})'),
            ),
            body: ListView(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(16.0),
                    itemCount: viewModel.rows.length,
                    itemBuilder: (_, index) {
                      return _WordRow(
                        viewModelRow: viewModel.rows[index],
                        index: index,
                      );
                    }),
                _ActionSet(viewState),
              ],
            ),
          );
        }
        return Center(
          child: Text('Error'),
        );
      },
    );
  }
}

class _WordRow extends StatelessWidget {
  final ViewRowModel viewModelRow;
  final int index;
  _WordRow({this.viewModelRow, this.index});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<WordListPresenter>(context);

    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          decoration: BoxDecoration(
            border: Border.all(
                color: viewModelRow.isWordSelected
                    ? Colors.blueGrey[900]
                    : Colors.black),
            color:
                viewModelRow.isWordSelected ? Colors.blue[900] : Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ListTile(
              title: Text(
                viewModelRow.wordName,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: viewModelRow.isWordSelected
                        ? Colors.white
                        : Colors.blue[900]),
              ),
              onTap: () {
                bloc.setSelection(index);
              }),
        )
      ],
    );
  }
}

class _ActionSet extends StatelessWidget {
  final ViewState viewState;

  _ActionSet(this.viewState);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<WordListPresenter>(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _ActionButton(
              '^\n|',
              viewState.initialState ? null : bloc.up,
            ),
            _ActionButton(
              '|\nV',
              !viewState.initialState || !viewState.getMoreEnabled
                  ? bloc.down
                  : null,
            ),
            _ActionButton(
              'Get\nMore',
              viewState.initialState && viewState.getMoreEnabled
                  ? bloc.getMore
                  : null,
            ),
          ],
        ),
        const SizedBox(height: 20),
        _ActionButton(
          'ShowSelection',
          viewState.showSelection
              ? () {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) => showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Hi'),
                        content: Text(
                            'Your selected word is ${bloc.getSelectedWord()}'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              : null,
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String buttonText;
  final Function buttonAction;

  _ActionButton(this.buttonText, this.buttonAction);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.blue[900],
      disabledColor: Colors.blue[200],
      onPressed: buttonAction,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
