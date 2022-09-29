import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../store/gopro/settings_store.dart';

class ExperimentalPage extends StatefulWidget {
  const ExperimentalPage({Key? key}) : super(key: key);

  @override
  State<ExperimentalPage> createState() => _ExperimentalPageState();
}

class _ExperimentalPageState extends State<ExperimentalPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildMaterialApp();
  }

  Widget buildState() {
    List<Widget> items = [];
    for (var key in SettingsStore.store.state.keys) {
      var value = SettingsStore.store.state[key];
      items.add(
        Text(
          '${key.toString()} : ${value.toString()}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      );
    }
    return Observer(
      builder: (context) => Column(children: items),
    );
  }

  Material buildMaterialApp() {
    return Material(
      child: Container(
        padding: const EdgeInsets.only(top: 100),
        decoration: const BoxDecoration(color: Color(0xff1F2123)),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: buildState(),
        ),
      ),
    );
  }
}
