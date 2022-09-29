import 'package:localstorage/localstorage.dart';
import 'package:toast/toast.dart';

import '../navigator/navigator.dart';
import './navigator/navigation_bar.dart';
import 'package:flutter/material.dart';

import 'services/gopro/connector.dart';

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppPageState();
}

class _MainAppPageState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    GoproConnector.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xff1F2123),
        ),
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Stack(
            children: <Widget>[
              Positioned(
                child: PageNavigator(
                  initialRoute: "/gallery",
                ),
                bottom: 70,
                left: 0,
                right: 0,
                top: 0,
              ),
              const Positioned(
                bottom: 0,
                left: 0,
                child: MainNavigationBar(),
              ),
            ],
          );
        }),
      ),
    );
  }
}
