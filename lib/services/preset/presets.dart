import 'package:flutter/widgets.dart';
import 'package:localstorage/localstorage.dart';

import '../service.dart';

class _PresetsService implements Service {
  LocalStorage? _localStorage;
  @override
  Future<void> init({BuildContext? context}) async {
    _localStorage = LocalStorage('gopro_presets');
    await _localStorage!.ready.then((value) {
      var x = _localStorage!.getItem('x');
    });
  }
}

class Presets {
  static final _PresetsService _service = _PresetsService();
  static _PresetsService get service => _service;
}
