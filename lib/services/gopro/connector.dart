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
  static LocalStorage? _localStorage;
  static FlutterBlue? bluetoothService;
  static bool isConnecting = false;

  static void init() async {
    FlutterBlue.instance.setLogLevel(LogLevel.critical);
    bluetoothService = FlutterBlue.instance;
    _localStorage = LocalStorage('gopro_connector');
    await _localStorage!.ready.then((value) {
      var loadedGoproId = _localStorage!.getItem('lastGoproId');
      if (loadedGoproId != null) {
        ConnectorStore.store.setLastGoproId(loadedGoproId);
      }
    });
    startScanning();
  }

  static Future<void> startScanning({manualScan = false}) async {
    await bluetoothService!.stopScan();
    ConnectorStore.store.setConnectedStatus(false);
    bluetoothService!.startScan(allowDuplicates: false);

    bluetoothService!.scanResults.listen((results) async {
      var allDevicesWithName =
          results.where((r) => r.device.name != "").toList();
      ConnectorStore.store.setScanResults(allDevicesWithName);
      if (manualScan || ConnectorStore.store.lastGoproId == null) return;
      for (ScanResult result in allDevicesWithName) {
        if (result.device.id.id == ConnectorStore.store.lastGoproId) {
          await connectToDevice(result.device);
        }
      }
    });
  }

  static Future<void> saveLastGoproId(BluetoothDevice device) async {
    try {
      await _localStorage!.setItem('lastGoproId', device.id.id);
    } catch (exception) {
      Logger.log("Error saving last gopro id: $exception", Logger.red);
    }
  }

  static Future<void> connectToDevice(BluetoothDevice device) async {
    if (isConnecting) return;
    isConnecting = true;
    await bluetoothService!.stopScan();
    var service = GoproService();
    try {
      await service.connect(device);
    } catch (exception) {
      isConnecting = false;
      startScanning();
      return;
    }
    ConnectorStore.store.setConnectedStatus(true);
    Logger.log("Connected to ${device.name}", Logger.yellow);
    ServicesStore.store.setGoproService(service);
    await saveLastGoproId(device);
    ConnectorStore.store.setLastGopro(device);
    QueryRequest requestAll =
        QueryRequest.fromList([Setting.Resolution, Setting.FPS]);
    await service.sendQuery(requestAll);
    isConnecting = false;
  }
}
