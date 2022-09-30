import 'package:mobx/mobx.dart';
import '../../models/preset.dart';
import '../../services/gopro/settings.dart';

part 'presets_store.g.dart';

class PresetsStoreA = PresetsStoreBase with _$PresetsStoreA;

abstract class PresetsStoreBase with Store {
  @observable
  ObservableList<PresetModel> presets = ObservableList<PresetModel>();

  @action
  void addPreset(PresetModel preset) {
    presets.add(preset);
  }

  @action
  void load(List<PresetModel> preset) {
    presets.clear();
    presets.addAll(preset);
  }
}

class PresetsStore {
  static final PresetsStoreA store = PresetsStoreA();
}
