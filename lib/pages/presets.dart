import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../components/presets/preset_list.dart';
import '../components/presets/preset_list_card.dart';
import '../store/presets/presets_store.dart';

class PresetsPage extends StatefulWidget {
  const PresetsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PresetsPageState();
  }
}

class _PresetsPageState extends State<PresetsPage> {
  Widget listDevices() {
    return Observer(
      builder: (_) => ListView.builder(
        shrinkWrap: true,
        itemCount: PresetsStore.store.presets.length,
        itemBuilder: (context, index) {
          var item = PresetsStore.store.presets[index];
          return TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            onPressed: () => {},
            child: Text(item.title!),
          );
        },
      ),
    );
  }

  void addNewPreset() {
    for (var i = 0; i < 50; i++) {
      PresetsStore.store.addPreset(PresetModel.create(
          'My preset $i', i, PresetCardGradient.getPreferedRandomGradient()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.only(top: 100),
        decoration: const BoxDecoration(color: Color(0xff1F2123)),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: 1600,
            width: 100,
            child: Column(
              children: <Widget>[
                PresetList(
                  presets: PresetsStore.store.presets,
                ),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: addNewPreset,
                  child: const Text("Add preset"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
