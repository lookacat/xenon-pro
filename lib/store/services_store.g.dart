// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ServicesStoreA on ServicesStoreBase, Store {
  late final _$goproServiceAtom =
      Atom(name: 'ServicesStoreBase.goproService', context: context);

  @override
  GoproService? get goproService {
    _$goproServiceAtom.reportRead();
    return super.goproService;
  }

  @override
  set goproService(GoproService? value) {
    _$goproServiceAtom.reportWrite(value, super.goproService, () {
      super.goproService = value;
    });
  }

  late final _$ServicesStoreBaseActionController =
      ActionController(name: 'ServicesStoreBase', context: context);

  @override
  void setGoproService(GoproService service) {
    final _$actionInfo = _$ServicesStoreBaseActionController.startAction(
        name: 'ServicesStoreBase.setGoproService');
    try {
      return super.setGoproService(service);
    } finally {
      _$ServicesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
goproService: ${goproService}
    ''';
  }
}
