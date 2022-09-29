import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../services/gopro/connector.dart';
import '../store/gopro/connector_store.dart';

class ConnectPage extends StatefulWidget {
  const ConnectPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ConnectPageState();
  }
}

class _ConnectPageState extends State<ConnectPage> {
  Widget listDevices() {
    return Observer(
      builder: (_) => ListView.builder(
        itemCount: ConnectorStore.store.scanResults.length,
        itemBuilder: (context, index) {
          var item = ConnectorStore.store.scanResults[index];
          return TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            onPressed: () => GoproConnector.connectToDevice(item.device),
            child: Observer(builder: (_) => Text(item.device.name)),
          );
        },
      ),
    );
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
