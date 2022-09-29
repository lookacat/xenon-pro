import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../services/gopro/query.dart';
import '../services/gopro/settings.dart';
import '../store/gopro/settings_store.dart';
import '../store/services_store.dart';

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

  Color primaryColor() {
    return const Color.fromARGB(255, 249, 35, 35);
  }

  List<DataColumn> _createSettingsColumns() {
    return [
      const DataColumn(
        label: Text(
          'Setting',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const DataColumn(
        label: Text(
          'Value',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ];
  }

  List<DataRow> _createSettingsRows() {
    List<DataRow> items = [];
    for (var key in SettingsStore.store.state.keys) {
      var value = SettingsStore.store.state[key];
      items.add(
        DataRow(cells: [
          DataCell(
            Text(
              key.toString(),
              style: TextStyle(color: primaryColor()),
            ),
          ),
          DataCell(
            Text(
              value.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ]),
      );
    }
    return items;
  }

  List<DataColumn> _createDeviceColumns() {
    return [
      const DataColumn(
        label: Text(
          'Attribute',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const DataColumn(
        label: Text(
          'Value',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ];
  }

  List<DataRow> _createDeviceRows() {
    List<DataRow> items = [];
    var device = ServicesStore.store.goproService!.getDevice()!;
    var deviceData = {
      'Name': device.name,
      'ID': device.id.id,
      'MTU': device.mtu,
      'Type': device.type
    };
    for (var key in deviceData.keys) {
      var value = deviceData[key];
      items.add(
        DataRow(cells: [
          DataCell(
            Text(
              key.toString(),
              style: TextStyle(color: primaryColor()),
            ),
          ),
          DataCell(
            Text(
              value.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ]),
      );
    }
    return items;
  }

  void refreshState() async {
    var activeService = ServicesStore.store.goproService;
    if (activeService == null) return;
    QueryRequest requestAll =
        QueryRequest.fromList([Setting.Resolution, Setting.FPS]);

    await activeService.sendQuery(requestAll);
  }

  Widget buildSettingsDataTable() {
    refreshState();
    return Observer(
      builder: (context) => Theme(
        data: Theme.of(context)
            .copyWith(dividerColor: Color.fromARGB(30, 255, 255, 255)),
        child: DataTable(
          columns: _createSettingsColumns(),
          rows: _createSettingsRows(),
          dividerThickness: 2,
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 24, 24, 24)),
        ),
      ),
    );
  }

  Widget buildDeviceDataTable() {
    refreshState();
    return Observer(
      builder: (context) => Theme(
        data: Theme.of(context)
            .copyWith(dividerColor: Color.fromARGB(30, 255, 255, 255)),
        child: DataTable(
          columns: _createDeviceColumns(),
          rows: _createDeviceRows(),
          dividerThickness: 2,
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 24, 24, 24)),
        ),
      ),
    );
  }

  Material buildMaterialApp() {
    return Material(
      child: Container(
        padding: const EdgeInsets.only(top: 40),
        decoration: const BoxDecoration(color: Color(0xff1F2123)),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              buildSettingsDataTable(),
              buildDeviceDataTable(),
            ],
          ),
        ),
      ),
    );
  }
}
