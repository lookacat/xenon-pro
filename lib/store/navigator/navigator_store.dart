import 'dart:developer';

import 'package:mobx/mobx.dart';

import '../../navigator/navigator.dart';

part 'navigator_store.g.dart';

class NavigatorStoreA = NavigatorStoreBase with _$NavigatorStoreA;

abstract class NavigatorStoreBase with Store {
  @observable
  String route = '/connect';

  @observable
  Map<String, dynamic>? routeParameters;

  @action
  void changeRoute(String value, {Map<String, dynamic>? parameters}) {
    navigationKey.currentState!.pushReplacementNamed(value);
    route = value;
    if (parameters != null) {
      routeParameters = parameters;
    } else {
      routeParameters = <String, dynamic>{};
    }
    log("Navigated to route: $route");
  }

  @action
  goBack() {
    navigationKey.currentState!.pop();
  }
}

class NavigatorStore {
  static final NavigatorStoreA store = NavigatorStoreA();
}
