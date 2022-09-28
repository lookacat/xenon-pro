import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import '../logger.dart';
import '../services/gopro/constants.dart';
import '../services/gopro/gopro.dart';
import '../services/gopro/query.dart';
import '../services/gopro/settings.dart';

class ConnectPage extends StatefulWidget {
  const ConnectPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ConnectPageState();
  }
}

class _ConnectPageState extends State<ConnectPage> {
  List<ScanResult> foundDevices = [];

  void refreshDevices() {
    FlutterBlue flutterBlue = FlutterBlue.instance;
    FlutterBlue.instance.setLogLevel(LogLevel.critical);
    flutterBlue.startScan(timeout: const Duration(seconds: 4));
    List<DeviceIdentifier> loggedIds = [];
    flutterBlue.scanResults.listen((results) {
      for (ScanResult r in results) {
        if (r.device.name == '') continue;
        if (loggedIds.contains(r.device.id)) continue;
        Logger.log('[BLE Search] ${r.device.name} found!', Logger.green);
        loggedIds.add(r.device.id);
      }
      setState(() {
        foundDevices = results;
      });
    });

    // Stop scanning
    flutterBlue.stopScan();
  }

  void connectToDevice(BluetoothDevice device) async {
    var service = GoproService();
    await service.connect(device);

    sleep(const Duration(seconds: 1));
    QueryRequest requestAll =
        QueryRequest.fromList([Setting.Resolution, Setting.FPS]);

    await service.sendQuery(requestAll);
    SettingsRequest settings =
        SettingsRequest(Setting.Resolution, Resolution.r_53K_43);
    await service.sendSettings(settings);
    SettingsRequest settings2 = SettingsRequest(Setting.FPS, FPS.fps_24);
    await service.sendSettings(settings2);
  }

  Widget listDevices() {
    List<Widget> show = [];
    for (ScanResult result in foundDevices) {
      if (result.device.name == '') continue;
      var button = TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
        ),
        onPressed: () => connectToDevice(result.device),
        child: Text(result.device.name),
      );
      show.add(button);
    }
    return Column(children: show);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.only(top: 100),
        child: Center(
          child: Column(
            children: [
              listDevices(),
              TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: refreshDevices,
                child: const Text(
                  'Refresh devices',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
