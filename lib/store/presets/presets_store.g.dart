// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'presets_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PresetsStoreA on PresetsStoreBase, Store {
  late final _$presetsAtom =
      Atom(name: 'PresetsStoreBase.presets', context: context);

  @override
  ObservableList<PresetModel> get presets {
    _$presetsAtom.reportRead();
    return super.presets;
  }

  @override
  set presets(ObservableList<PresetModel> value) {
    _$presetsAtom.reportWrite(value, super.presets, () {
      super.presets = value;
    });
  }

  late final _$PresetsStoreBaseActionController =
      ActionController(name: 'PresetsStoreBase', context: context);

  @override
  void addPreset(PresetModel preset) {
    final _$actionInfo = _$PresetsStoreBaseActionController.startAction(
        name: 'PresetsStoreBase.addPreset');
    try {
      return super.addPreset(preset);
    } finally {
      _$PresetsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void load(List<PresetModel> preset) {
    final _$actionInfo = _$PresetsStoreBaseActionController.startAction(
        name: 'PresetsStoreBase.load');
    try {
      return super.load(preset);
    } finally {
      _$PresetsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
presets: ${presets}
    ''';
  }
}
