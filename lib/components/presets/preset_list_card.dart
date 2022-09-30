import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../store/presets/presets_store.dart';

class PresetListCard extends StatelessWidget {
  final PresetModel preset;

  const PresetListCard({
    Key? key,
    required this.preset,
  }) : super(key: key);

  void onPresetTap() {
    HapticFeedback.heavyImpact();
    preset.activate();
  }

  BoxDecoration getCardDecoration() {
    return BoxDecoration(
      border: preset.active
          ? Border.all(color: Color.fromARGB(160, 255, 255, 255), width: 2.5)
          : Border.all(width: 0),
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: preset.active
            ? [
                Color.fromARGB(255, 240, 106, 22),
                Color.fromARGB(255, 249, 35, 35),
              ]
            : [
                Color.fromARGB(100, 240, 106, 22),
                Color.fromARGB(100, 249, 35, 35),
              ],
      ),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPresetTap,
      child: Observer(
        builder: (_) => AnimatedContainer(
          decoration: getCardDecoration(),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
          padding: const EdgeInsets.all(20),
          child: Observer(
            builder: (_) => Text(
              preset.title!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
