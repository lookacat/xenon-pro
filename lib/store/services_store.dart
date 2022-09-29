import 'package:mobx/mobx.dart';
import '../../services/gopro/gopro.dart';

part 'services_store.g.dart';

class ServicesStoreA = ServicesStoreBase with _$ServicesStoreA;

abstract class ServicesStoreBase with Store {
  @observable
  GoproService? goproService;

  @action
  void setGoproService(GoproService service) {
    goproService = service;
  }
}

class ServicesStore {
  static final ServicesStoreA store = ServicesStoreA();
}
