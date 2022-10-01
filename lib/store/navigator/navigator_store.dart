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
  void changeRoute(String value, {dynamic parameters}) {
    navigationKey.currentState!
        .pushReplacementNamed(value, arguments: parameters);
    route = value;
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
