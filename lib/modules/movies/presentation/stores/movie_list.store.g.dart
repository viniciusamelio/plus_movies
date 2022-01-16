// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_list.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MovieListStore on _MovieListStoreBase, Store {
  final _$selectedGenreIndexAtom =
      Atom(name: '_MovieListStoreBase.selectedGenreIndex');

  @override
  int get selectedGenreIndex {
    _$selectedGenreIndexAtom.reportRead();
    return super.selectedGenreIndex;
  }

  @override
  set selectedGenreIndex(int value) {
    _$selectedGenreIndexAtom.reportWrite(value, super.selectedGenreIndex, () {
      super.selectedGenreIndex = value;
    });
  }

  final _$listMoviesReactionAtom =
      Atom(name: '_MovieListStoreBase.listMoviesReaction');

  @override
  ObservableFuture<Either<CoreError, List<Movie>>>? get listMoviesReaction {
    _$listMoviesReactionAtom.reportRead();
    return super.listMoviesReaction;
  }

  @override
  set listMoviesReaction(
      ObservableFuture<Either<CoreError, List<Movie>>>? value) {
    _$listMoviesReactionAtom.reportWrite(value, super.listMoviesReaction, () {
      super.listMoviesReaction = value;
    });
  }

  final _$_MovieListStoreBaseActionController =
      ActionController(name: '_MovieListStoreBase');

  @override
  void selectGenre(int index) {
    final _$actionInfo = _$_MovieListStoreBaseActionController.startAction(
        name: '_MovieListStoreBase.selectGenre');
    try {
      return super.selectGenre(index);
    } finally {
      _$_MovieListStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void listMovies() {
    final _$actionInfo = _$_MovieListStoreBaseActionController.startAction(
        name: '_MovieListStoreBase.listMovies');
    try {
      return super.listMovies();
    } finally {
      _$_MovieListStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedGenreIndex: ${selectedGenreIndex},
listMoviesReaction: ${listMoviesReaction}
    ''';
  }
}
