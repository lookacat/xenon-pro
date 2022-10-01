import 'dart:convert';

import 'package:flutter/widgets.dart';

import '../service.dart';

class _CapabilitiesService implements Service {
  dynamic _capabilities;
  dynamic _readCapabilities(BuildContext context) async {
    String data =
        await DefaultAssetBundle.of(context).loadString("assets/data.json");
    _capabilities = jsonDecode(data);
  }

  @override
  Future<void> init({BuildContext? context}) async {
    await _readCapabilities(context!);
  }
}

class Capabilities {
  static final _CapabilitiesService _service = _CapabilitiesService();
  static _CapabilitiesService get service => _service;
}
