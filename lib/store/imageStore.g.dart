// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imageStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Counter on _Counter, Store {
  late final _$dataResponseAtom =
      Atom(name: '_Counter.dataResponse', context: context);

  @override
  List<dynamic> get dataResponse {
    _$dataResponseAtom.reportRead();
    return super.dataResponse;
  }

  @override
  set dataResponse(List<dynamic> value) {
    _$dataResponseAtom.reportWrite(value, super.dataResponse, () {
      super.dataResponse = value;
    });
  }

  late final _$loadedPagesAtom =
      Atom(name: '_Counter.loadedPages', context: context);

  @override
  int get loadedPages {
    _$loadedPagesAtom.reportRead();
    return super.loadedPages;
  }

  @override
  set loadedPages(int value) {
    _$loadedPagesAtom.reportWrite(value, super.loadedPages, () {
      super.loadedPages = value;
    });
  }

  late final _$loaderAtom = Atom(name: '_Counter.loader', context: context);

  @override
  bool get loader {
    _$loaderAtom.reportRead();
    return super.loader;
  }

  @override
  set loader(bool value) {
    _$loaderAtom.reportWrite(value, super.loader, () {
      super.loader = value;
    });
  }

  late final _$_CounterActionController =
      ActionController(name: '_Counter', context: context);

  @override
  void getImagesData(dynamic text, dynamic loadMore) {
    final _$actionInfo =
        _$_CounterActionController.startAction(name: '_Counter.getImagesData');
    try {
      return super.getImagesData(text, loadMore);
    } finally {
      _$_CounterActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetImgData() {
    final _$actionInfo =
        _$_CounterActionController.startAction(name: '_Counter.resetImgData');
    try {
      return super.resetImgData();
    } finally {
      _$_CounterActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
dataResponse: ${dataResponse},
loadedPages: ${loadedPages},
loader: ${loader}
    ''';
  }
}
