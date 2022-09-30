import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../store/presets/presets_store.dart';
import 'preset_list_card.dart';

class PresetList extends StatelessWidget {
  final List<PresetModel> presets;

  const PresetList({Key? key, required this.presets}) : super(key: key);

  Widget buildList() {
    return Observer(
      builder: (_) => ListView.builder(
        shrinkWrap: true,
        itemCount: presets.length,
        itemBuilder: (context, index) {
          var item = presets[index];
          return Observer(builder: (_) => PresetListCard(preset: item));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 2000, minHeight: 56.0),
      child: buildList(),
    );
  }
}
