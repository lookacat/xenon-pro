import 'package:flutter_blue/flutter_blue.dart';
import 'package:mobx/mobx.dart';

part 'connector_store.g.dart';

class ConnectorStoreA = ConnectorStoreBase with _$ConnectorStoreA;

abstract class ConnectorStoreBase with Store {
  @observable
  String? lastGoproId;

  @observable
  bool isConnected = false;

  @observable
  ObservableList<ScanResult> scanResults = ObservableList<ScanResult>();

  @action
  void setScanResults(List<ScanResult> results) {
    scanResults.clear();
    scanResults.addAll(results);
  }

  @action
  void setConnectedStatus(bool status) {
    isConnected = status;
  }

  @action
  void setLastGoproId(String id) {
    lastGoproId = id;
  }

  @action
  void setLastGopro(BluetoothDevice device) {
    lastGoproId = device.id.id;
  }
}

class ConnectorStore {
  static final ConnectorStoreA store = ConnectorStoreA();
}
