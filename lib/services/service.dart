import 'package:flutter/widgets.dart';

abstract class Service {
  Future<void> init({BuildContext context});
}
