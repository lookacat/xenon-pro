// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connector_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ConnectorStoreA on ConnectorStoreBase, Store {
  late final _$lastGoproIdAtom =
      Atom(name: 'ConnectorStoreBase.lastGoproId', context: context);

  @override
  String? get lastGoproId {
    _$lastGoproIdAtom.reportRead();
    return super.lastGoproId;
  }

  @override
  set lastGoproId(String? value) {
    _$lastGoproIdAtom.reportWrite(value, super.lastGoproId, () {
      super.lastGoproId = value;
    });
  }

  late final _$scanResultsAtom =
      Atom(name: 'ConnectorStoreBase.scanResults', context: context);

  @override
  ObservableList<ScanResult> get scanResults {
    _$scanResultsAtom.reportRead();
    return super.scanResults;
  }

  @override
  set scanResults(ObservableList<ScanResult> value) {
    _$scanResultsAtom.reportWrite(value, super.scanResults, () {
      super.scanResults = value;
    });
  }

  late final _$ConnectorStoreBaseActionController =
      ActionController(name: 'ConnectorStoreBase', context: context);

  @override
  void setScanResults(List<ScanResult> results) {
    final _$actionInfo = _$ConnectorStoreBaseActionController.startAction(
        name: 'ConnectorStoreBase.setScanResults');
    try {
      return super.setScanResults(results);
    } finally {
      _$ConnectorStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLastGopro(BluetoothDevice device) {
    final _$actionInfo = _$ConnectorStoreBaseActionController.startAction(
        name: 'ConnectorStoreBase.setLastGopro');
    try {
      return super.setLastGopro(device);
    } finally {
      _$ConnectorStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
lastGoproId: ${lastGoproId},
scanResults: ${scanResults}
    ''';
  }
}
