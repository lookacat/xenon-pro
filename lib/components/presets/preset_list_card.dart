import 'dart:math';

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
    Gradient presetGradient = PresetCardGradient.gradients[preset.gradient!]!;
    Color gr1 = presetGradient.start;
    Color gr2 = presetGradient.end;
    return BoxDecoration(
      border: preset.active
          ? Border.all(color: Color.fromARGB(160, 255, 255, 255), width: 2.5)
          : Border.all(width: 0),
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: preset.active
            ? [
                Color.fromARGB(255, gr1.red, gr1.green, gr1.blue),
                Color.fromARGB(255, gr2.red, gr2.green, gr2.blue),
              ]
            : [
                Color.fromARGB(100, gr1.red, gr1.green, gr1.blue),
                Color.fromARGB(100, gr2.red, gr2.green, gr2.blue),
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

class Gradient {
  final Color start;
  final Color end;

  const Gradient({
    required this.start,
    required this.end,
  });
}

class PresetCardGradient {
  static final Map<String, Gradient> gradients = {
    'red1': const Gradient(
      start: Color.fromARGB(255, 240, 106, 22),
      end: Color.fromARGB(255, 249, 35, 35),
    ),
    'yellow1': const Gradient(
      start: Color.fromARGB(255, 253, 255, 145),
      end: Color.fromARGB(255, 255, 191, 0),
    ),
    'blue1': const Gradient(
      start: Color.fromARGB(255, 0, 211, 219),
      end: Color.fromARGB(255, 0, 89, 255),
    ),
    'green1': const Gradient(
      start: Color.fromARGB(255, 79, 249, 189),
      end: Color.fromARGB(255, 41, 204, 0),
    ),
    'beautiful1': const Gradient(
      start: Color(0xFFFDFC47),
      end: Color.fromARGB(255, 0, 172, 23),
    ),
    'beautiful2': const Gradient(
      start: Color(0xFFb6fbff),
      end: Color(0xFF83a4d4),
    ),
    'beautiful3': const Gradient(
      start: Color(0xFFf83600),
      end: Color(0xFFfe8c00),
    ),
    'beautiful4': const Gradient(
      start: Color(0xFF6E48AA),
      end: Color(0xFF9D50BB),
    ),
  };

  static String getPreferedRandomGradient() {
    var usedGradients = [];
    for (var preset in PresetsStore.store.presets) {
      if (preset.gradient == null) continue;
      usedGradients.add(preset.gradient);
    }
    var availableGradients = gradients.keys
        .where((element) => !usedGradients.contains(element))
        .toList();
    if (availableGradients.isEmpty)
      availableGradients = gradients.keys.toList();
    final random = Random();
    final index = random.nextInt(availableGradients.length);
    return availableGradients.elementAt(index);
  }
}
