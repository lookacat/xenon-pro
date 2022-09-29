import 'package:flutter_blue/flutter_blue.dart';
import 'package:mobx/mobx.dart';

import '../../services/gopro/gopro.dart';
import '../../services/gopro/settings.dart';

part 'settings_store.g.dart';

class SettingsStoreA = SettingsStoreBase with _$SettingsStoreA;

abstract class SettingsStoreBase with Store {
  @observable
  String? lastGoproId;

  @observable
  ObservableMap<Setting, dynamic> state = ObservableMap.of({});

  @action
  void setSetting(Setting setting, dynamic value) {
    state[setting] = value;
  }

  @action
  void setLastGopro(BluetoothDevice device) {
    lastGoproId = device.id.id;
  }
}

class SettingsStore {
  static final SettingsStoreA store = SettingsStoreA();
}
