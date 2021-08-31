import 'package:flutter/material.dart';
import 'package:word_selector/ui/common/bloc_builder.dart';
import 'package:word_selector/ui/common/bloc_provider.dart';
import 'package:word_selector/ui/common/constants.dart';
import 'package:word_selector/ui/word_list/presenter/word_list_presenter.dart';
import 'package:word_selector/ui/word_list/presenter/word_list_presenter_output.dart';
import 'package:word_selector/ui/word_list/presenter/word_list_view_model.dart';

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
          return Scaffold(
            appBar: AppBar(
              title: Text('Word List (${viewModel.rows.length})'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 400,
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.all(16.0),
                      itemCount: viewModel.rows.length,
                      itemBuilder: (_, index) {
                        return Container(
                          height: 400 / VISIBLE_WORDS_COUNT - 10,
                          child: _WordRow(
                            viewModelRow: viewModel.rows[index],
                            index: index,
                          ),
                        );
                      }),
                ),
                _ActionSet(),
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

    return GestureDetector(
        child: Container(
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
          child: Center(
            child: Text(
              viewModelRow.wordName,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: viewModelRow.isWordSelected
                      ? Colors.white
                      : Colors.blue[900]),
            ),
          ),
        ),
        onTap: () {
          bloc.setSelectedWord(index);
        });
  }
}

class _ActionSet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<WordListPresenter>(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _ActionButton(
                '^\n|',
                bloc.up ? bloc.moveListDown : null,
              ),
              _ActionButton(
                '|\nV',
                bloc.down ? bloc.moveListUp : null,
              ),
              _ActionButton(
                'Get\nMore',
                bloc.getMore ? bloc.getMoreWords : null,
              ),
            ],
          ),
          const SizedBox(height: 20),
          _ActionButton(
            'ShowSelection',
            bloc.showSelection
                ? () {
                    WidgetsBinding.instance.addPostFrameCallback(
                      (_) => showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Hi'),
                          content:
                              Text('Your selected word is ${bloc.selectedWord}'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context),
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
      ),
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
