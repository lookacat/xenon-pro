// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ionicons/ionicons.dart';

import '../components/connection_status.dart';
import '../models/navigation_bar_item.dart';
import '../store/gopro/connector_store.dart';
import 'navigation_bar_item.dart';

class MainNavigationBar extends StatefulWidget {
  const MainNavigationBar({Key? key}) : super(key: key);

  @override
  State<MainNavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<MainNavigationBar> {
  @override
  void initState() {
    super.initState();
  }

  BoxDecoration buildContainerDecoration() {
    return BoxDecoration(
      color: const Color(0xff1F2123),
      border: const Border(
        top: BorderSide(
          width: 1,
          color: Color.fromARGB(255, 84, 89, 95),
        ),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          spreadRadius: 4,
          blurRadius: 18,
          offset: const Offset(0, 0),
        ),
      ],
    );
  }

  Widget buildItemRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        NavigationBarItem(
          model: NavigationBarItemModel(
            title: "Connect",
            target: "/connect",
            icon: Ionicons.home,
          ),
        ),
        NavigationBarItem(
          model: NavigationBarItemModel(
            title: "Experimental",
            target: "/experimental",
            icon: Ionicons.images_outline,
          ),
        ),
        NavigationBarItem(
          model: NavigationBarItemModel(
            title: "Presets",
            target: "/presets",
            icon: Ionicons.folder_outline,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Observer(
        builder: (context) => ConnectionStatus(
          connected: ConnectorStore.store.isConnected,
        ),
      ),
      Container(
        height: 70 + MediaQuery.of(context).padding.bottom,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        decoration: buildContainerDecoration(),
        child: buildItemRow(),
      )
    ]);
  }
}
