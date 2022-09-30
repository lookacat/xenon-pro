import 'package:mobx/mobx.dart';
import 'package:flutter_guid/flutter_guid.dart';
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
  void setActivePreset(String id) {
    for (var element in presets) {
      element.active = false;
    }
    presets.firstWhere((element) => element.id == id).active = true;
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

class PresetModel = _PresetModel with _$PresetModel;

abstract class _PresetModel with Store {
  @observable
  String? id;

  @observable
  String? title;

  @observable
  int? index;

  @observable
  bool active = false;

  _PresetModel();
  _PresetModel.create(this.title, this.index) {
    id = Guid.newGuid.toString();
  }

  @action
  void activate() {
    PresetsStore.store.setActivePreset(id!);
  }
}
