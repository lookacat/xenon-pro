import 'package:flutter_guid/flutter_guid.dart';

class PresetModel {
  String? id;
  String? title;
  int? index;

  PresetModel();
  PresetModel.create(this.title, this.index) {
    id = Guid.newGuid.toString();
  }
}
