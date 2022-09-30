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
  void setActivePreset(String id) {
    final _$actionInfo = _$PresetsStoreBaseActionController.startAction(
        name: 'PresetsStoreBase.setActivePreset');
    try {
      return super.setActivePreset(id);
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

mixin _$PresetModel on _PresetModel, Store {
  late final _$idAtom = Atom(name: '_PresetModel.id', context: context);

  @override
  String? get id {
    _$idAtom.reportRead();
    return super.id;
  }

  @override
  set id(String? value) {
    _$idAtom.reportWrite(value, super.id, () {
      super.id = value;
    });
  }

  late final _$titleAtom = Atom(name: '_PresetModel.title', context: context);

  @override
  String? get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String? value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  late final _$indexAtom = Atom(name: '_PresetModel.index', context: context);

  @override
  int? get index {
    _$indexAtom.reportRead();
    return super.index;
  }

  @override
  set index(int? value) {
    _$indexAtom.reportWrite(value, super.index, () {
      super.index = value;
    });
  }

  late final _$activeAtom = Atom(name: '_PresetModel.active', context: context);

  @override
  bool get active {
    _$activeAtom.reportRead();
    return super.active;
  }

  @override
  set active(bool value) {
    _$activeAtom.reportWrite(value, super.active, () {
      super.active = value;
    });
  }

  late final _$gradientAtom =
      Atom(name: '_PresetModel.gradient', context: context);

  @override
  String? get gradient {
    _$gradientAtom.reportRead();
    return super.gradient;
  }

  @override
  set gradient(String? value) {
    _$gradientAtom.reportWrite(value, super.gradient, () {
      super.gradient = value;
    });
  }

  late final _$_PresetModelActionController =
      ActionController(name: '_PresetModel', context: context);

  @override
  void activate() {
    final _$actionInfo = _$_PresetModelActionController.startAction(
        name: '_PresetModel.activate');
    try {
      return super.activate();
    } finally {
      _$_PresetModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
id: ${id},
title: ${title},
index: ${index},
active: ${active},
gradient: ${gradient}
    ''';
  }
}
