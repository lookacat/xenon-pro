// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../pages/connect.dart';
import '../pages/experimental.dart';

final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

class PageNavigator extends StatelessWidget {
  final String initialRoute;

  PageNavigator({
    Key? key,
    required this.initialRoute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Navigator(
          key: navigationKey,
          initialRoute: initialRoute,
          onGenerateRoute: (RouteSettings routeSettings) {
            switch (routeSettings.name) {
              case '/connect':
                return PageTransition(
                    type: PageTransitionType.fade,
                    child: const ConnectPage(),
                    duration: const Duration(milliseconds: 200));
              case '/experimental':
                return PageTransition(
                    type: PageTransitionType.fade,
                    child: const ExperimentalPage(),
                    duration: const Duration(milliseconds: 200));
              default:
                return PageTransition(
                    type: PageTransitionType.fade,
                    child: const ConnectPage(),
                    duration: const Duration(milliseconds: 200));
            }
          },
        ),
        onWillPop: () {
          if (navigationKey.currentState!.canPop()) {
            navigationKey.currentState!.pop();
            return Future<bool>.value(false);
          }
          return Future<bool>.value(true);
        });
  }
}
