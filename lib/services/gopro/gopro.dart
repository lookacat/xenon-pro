import 'package:flutter_blue/flutter_blue.dart';

import '../../logger.dart';

class GoproService {
  BluetoothDevice? _device;
  List<BluetoothService>? _services;

  Future<void> connect(BluetoothDevice device) async {
    if (_device != null) {
      await _device?.disconnect();
    }
    _device = device;
    await _device?.connect();
    await _initAfterConnect();
  }

  Future<void> _initAfterConnect() async {
    _services = await _device?.discoverServices();
    var commandResponse = _getCharacteristics('0073')!;
    await commandResponse.setNotifyValue(true);
    commandResponse.value.listen((value) {
      Logger.log("[GoPro][Command-Response] $value", Logger.magenta);
    });
    var settingsResponse = _getCharacteristics('0075')!;
    await settingsResponse.setNotifyValue(true);
    settingsResponse.value.listen((value) {
      Logger.log("[GoPro][Settings-Response] $value", Logger.red);
    });
  }

  BluetoothCharacteristic? _getCharacteristics(String id) {
    for (var service in _services!) {
      for (var characteristic in service.characteristics) {
        if (characteristic.uuid == Guid(_getUuid(id))) {
          return characteristic;
        }
      }
    }
    return null;
  }

  BluetoothCharacteristic? _getCommandCharacteristic() {
    return _getCharacteristics('0072');
  }

  Future<void> sendCommand(List<int> command) async {
    var characteristic = _getCommandCharacteristic();
    if (characteristic != null) {
      await characteristic.write(command);
    }
  }

  Future<dynamic> disconnect() async {
    return await _device?.disconnect();
  }

  String _getUuid(String param) {
    return 'b5f9$param-aa8d-11e3-9046-0002a5d5c51b';
  }
}
