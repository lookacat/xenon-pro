// ignore_for_file: deprecated_member_use

import 'package:flutter_blue/flutter_blue.dart';
import 'package:localstorage/localstorage.dart';

import '../../logger.dart';
import '../../store/gopro/connector_store.dart';
import '../../store/services_store.dart';
import 'gopro.dart';
import 'query.dart';
import 'settings.dart';

class GoproConnector {
  static final LocalStorage _localStorage = LocalStorage('gopro_connector');
  static FlutterBlue? bluetoothService;

  static void init() {
    FlutterBlue.instance.setLogLevel(LogLevel.critical);
    bluetoothService = FlutterBlue.instance;
    _localStorage.ready.then((value) {
      var loadedGoproId = _localStorage.getItem('lastGoproId');
      if (loadedGoproId != null) {
        ConnectorStore.store.setLastGoproId(loadedGoproId);
      }
      _startScanning();
    });
  }

  static void _startScanning({manualScan = false}) {
    bluetoothService!.startScan(allowDuplicates: false);

    bluetoothService!.scanResults.listen((results) async {
      var allDevicesWithName =
          results.where((r) => r.device.name != "").toList();
      ConnectorStore.store.setScanResults(allDevicesWithName);
      if (manualScan || ConnectorStore.store.lastGoproId == null) return;
      for (ScanResult result in results) {
        if (result.device.id.id == ConnectorStore.store.lastGoproId) {
          await connectToDevice(result.device);
        }
      }
    });
  }

  static Future<void> connectToDevice(BluetoothDevice device) async {
    await bluetoothService!.stopScan();
    var service = GoproService();
    await service.connect(device);
    ServicesStore.store.setGoproService(service);
    _localStorage.setItem('lastGoproId', device.id.id);
    Logger.log("!!!!  Connected to ${device.name}", Logger.yellow);
    ConnectorStore.store.setLastGopro(device);
    QueryRequest requestAll =
        QueryRequest.fromList([Setting.Resolution, Setting.FPS]);
    await service.sendQuery(requestAll);
  }
}
