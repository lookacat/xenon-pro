import 'package:mobx/mobx.dart';

import '../../services/gopro/settings.dart';

part 'settings_store.g.dart';

class SettingsStoreA = SettingsStoreBase with _$SettingsStoreA;

abstract class SettingsStoreBase with Store {
  @observable
  ObservableMap<Setting, dynamic> state = ObservableMap.of({});

  @action
  void setSetting(Setting setting, dynamic value) {
    state[setting] = value;
  }
}

class SettingsStore {
  static final SettingsStoreA store = SettingsStoreA();
}
