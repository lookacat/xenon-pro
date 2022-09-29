import 'package:flutter_blue/flutter_blue.dart';
import 'package:xenon/services/gopro/settings.dart';

import '../../logger.dart';
import '../../store/gopro/settings_store.dart';
import 'constants.dart';
import 'query.dart';

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
    var commandResponse =
        _getCharacteristics(Constants.CommandResponseServiceId)!;
    await commandResponse.setNotifyValue(true);
    commandResponse.value.listen((value) {
      Logger.log("[GoPro][Command-Response] $value", Logger.magenta);
    });
    var settingsResponse =
        _getCharacteristics(Constants.SettingsResponseServiceId)!;
    await settingsResponse.setNotifyValue(true);
    settingsResponse.value.listen((value) {
      Logger.log("[GoPro][Settings-Response] $value", Logger.red);
    });
    var queryResponse = _getCharacteristics(Constants.QueryResponseServiceId)!;
    await queryResponse.setNotifyValue(true);
    queryResponse.value.listen((value) {
      //Logger.log("[GoPro][Query-Response] $value", Logger.cyan);
      QueryResponse response = QueryResponse();
      response.parse(value);
      for (var setting in response.values.keys) {
        var value = response.values[setting];
        SettingsStore.store.setSetting(setting, value);
      }
    });
  }

  BluetoothCharacteristic? _getCharacteristics(String id) {
    for (var service in _services!) {
      for (var characteristic in service.characteristics) {
        if (characteristic.uuid == Guid(Constants.getUuid(id))) {
          return characteristic;
        }
      }
    }
    return null;
  }

  Future<void> sendCommand(List<int> command) async {
    var characteristic = _getCharacteristics(Constants.CommandRequestServiceId);
    if (characteristic != null) {
      await characteristic.write(command);
    }
  }

  Future<void> sendQuery(QueryRequest query) async {
    var characteristic = _getCharacteristics(Constants.QueryRequestServiceId);
    if (characteristic != null) {
      await characteristic.write(query.toQuery());
    }
  }

  Future<void> sendSettings(SettingsRequest setting) async {
    var characteristic =
        _getCharacteristics(Constants.SettingsRequestServiceId);
    if (characteristic != null) {
      await characteristic.write(setting.toQuery());
    }
  }

  Future<dynamic> disconnect() async {
    return await _device?.disconnect();
  }
}
