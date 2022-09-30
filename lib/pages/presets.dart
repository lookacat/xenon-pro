import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../models/preset.dart';
import '../services/gopro/connector.dart';
import '../store/gopro/connector_store.dart';
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
        itemCount: PresetsStore.store.presets.length,
        itemBuilder: (context, index) {
          var item = PresetsStore.store.presets[index];
          return TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            onPressed: () => {},
            child: Observer(builder: (_) => Text(item.title!)),
          );
        },
      ),
    );
  }

  void addNewPreset() {
    PresetsStore.store.addPreset(PresetModel.create("New Preset", 0));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(color: Color(0xff1F2123)),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: 1600,
            width: 100,
            padding: const EdgeInsets.only(top: 100),
            child: Column(
              children: [
                Expanded(
                  child: listDevices(),
                ),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: addNewPreset,
                  child: Observer(builder: (_) => const Text("Add preset")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
