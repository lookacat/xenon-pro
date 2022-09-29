import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:xenon/services/gopro/settings.dart';

import '../../logger.dart';
import '../../store/gopro/settings_store.dart';
import 'constants.dart';
import 'query.dart';

class GoproService {
  BluetoothDevice? _device;
  List<BluetoothService>? _services;
  bool isConnected = false;

  Future<void> connect(BluetoothDevice device) async {
    if (_device != null) {
      await _device?.disconnect();
    }
    _device = device;
    await _device?.connect();
    await _initAfterConnect();
  }

  Future<void> _initAfterConnect() async {
    isConnected = true;
    _device!.state.listen((state) {
      if (state == BluetoothDeviceState.disconnected) {
        isConnected = false;
      }
      Logger.log("Device Status changed: ${state}", Logger.green);
    });
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
    if (!isConnected) return;
    var characteristic = _getCharacteristics(Constants.CommandRequestServiceId);
    if (characteristic != null) {
      try {
        await characteristic.write(command);
      } on PlatformException catch (exception) {
        Logger.log(
            "[GoPro][Service] ${exception.code} Device not connected trying to send command! ${exception.details}",
            Logger.red);
      } catch (exception) {
        Logger.log(
            "[GoPro][Service] Uncaught exception sending command", Logger.red);
      }
    }
  }

  Future<void> sendQuery(QueryRequest query) async {
    if (!isConnected) return;
    var characteristic = _getCharacteristics(Constants.QueryRequestServiceId);
    if (characteristic != null) {
      try {
        await characteristic.write(query.toQuery());
      } on PlatformException catch (exception) {
        Logger.log(
            "[GoPro][Service] ${exception.code} Device not connected trying to send query! ${exception.details}",
            Logger.red);
      } catch (exception) {
        Logger.log(
            "[GoPro][Service] Uncaught exception sending query", Logger.red);
      }
    }
  }

  Future<void> sendSettings(SettingsRequest setting) async {
    if (!isConnected) return;
    var characteristic =
        _getCharacteristics(Constants.SettingsRequestServiceId);
    if (characteristic != null) {
      try {
        await characteristic.write(setting.toQuery());
      } on PlatformException catch (exception) {
        Logger.log(
            "[GoPro][ServiceException] ${exception.code} Device not connected trying to send settings! ${exception.details}",
            Logger.red);
      } catch (exception) {
        Logger.log(
            "[GoPro][ServiceException] Uncaught exception sending settings",
            Logger.red);
      }
    }
  }

  BluetoothDevice? getDevice() {
    return _device;
  }

  Future<dynamic> disconnect() async {
    if (!isConnected) return;
    return await _device?.disconnect();
  }
}
