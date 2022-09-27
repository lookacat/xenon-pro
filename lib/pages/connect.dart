import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blue/flutter_blue.dart';

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
    flutterBlue.startScan(timeout: const Duration(seconds: 4));

    flutterBlue.scanResults.listen((results) {
      for (ScanResult r in results) {
        print('${r.device.name} found! rssi: ${r.rssi}');
      }
      setState(() {
        foundDevices = results;
      });
    });

    // Stop scanning
    flutterBlue.stopScan();
  }

  void connectToDevice(BluetoothDevice device) async {
    await device.connect();
    const GOPRO_BASE_UUID = "b5f9{}-aa8d-11e3-9046-0002a5d5c51b";
    /*const SETTINGS_REQ_UUID = GOPRO_BASE_UUID.format("0074");
    const SETTINGS_RSP_UUID = GOPRO_BASE_UUID.format("0075")*/
    const test = "b5f90075-aa8d-11e3-9046-0002a5d5c51b";
    // Reads all descriptors
    List<BluetoothService> services = await device.discoverServices();
    services.forEach((service) async {
      var characteristics = service.characteristics;
      for (var c in characteristics) {
        await c.setNotifyValue(true);
        c.value.listen((value) {
          print("NEWVALUE:" + value.toString());
        });
        try {
          c.write([33]);
        } catch (ex) {}
      }
    });
    //device.services.length()

    // Writes to a descriptor
    //await d.write([0x12, 0x34])
    //await client.write_gatt_char(SETTINGS_REQ_UUID, bytearray([0x03, 0x02, 0x01, 0x09]), response=True)
    //await event.wait()
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
    return Center(
      child: Column(
        children: [
          listDevices(),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            onPressed: refreshDevices,
            child: Text('Refresh devices'),
          ),
        ],
      ),
    );
  }
}
