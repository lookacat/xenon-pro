// ignore_for_file: unused_element, import_of_legacy_library_into_null_safe

import 'package:mobx/mobx.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:collection/collection.dart';

import '../../components/presets/preset_list_card.dart';
import '../../services/gopro/settings.dart';
import '../services_store.dart';
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

  PresetModel? get activePreset {
    return presets.firstWhereOrNull((preset) => preset.active);
  }

  Gradient get activeGradientOrDefault {
    if (activePreset != null && activePreset!.gradient != null) {
      return PresetCardGradient.gradients[activePreset!.gradient]!;
    }
    return PresetCardGradient.gradients['default']!;
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

  @observable
  String? gradient;

  @observable
  ObservableMap<Setting, dynamic> settings = ObservableMap.of({});

  _PresetModel();
  _PresetModel.create(this.title, this.index, this.gradient) {
    id = Guid.newGuid.toString();
  }

  @action
  void activate() {
    PresetsStore.store.setActivePreset(id!);
    applySettings();
  }

  @action
  void setSetting(Setting setting, dynamic value) {
    settings[setting] = value;
  }

  @action
  void applySettings() {
    for (var setting in settings.keys) {
      var value = settings[setting];
      var request = SettingsRequest(setting, value);
      ServicesStore.store.goproService!.sendSettings(request);
    }
  }
}
