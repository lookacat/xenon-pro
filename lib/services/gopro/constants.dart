// ignore_for_file: constant_identifier_names, non_constant_identifier_names
enum Setting { Resolution, FPS }

enum Resolution {
  r_4K_169,
  r_27K_169,
  r_27K_43,
  r_1440_169,
  r_1080_169,
  r_4K_43,
  r_5K_169,
  r_5K_43,
  r_53K_87,
  r_53K_43,
  r_4K_87,
  r_53K_169
}

enum FPS {
  fps_240,
  fps_120,
  fps_100,
  fps_60,
  fps_50,
  fps_30,
  fps_25,
  fps_24,
  fps_200
}

class Constants {
  static const String CommandRequestServiceId = '0072';
  static const String CommandResponseServiceId = '0073';
  static const String SettingsRequestServiceId = '0074';
  static const String SettingsResponseServiceId = '0075';
  static const String QueryRequestServiceId = '0076';
  static const String QueryResponseServiceId = '0077';
  static String getUuid(String param) {
    return 'b5f9$param-aa8d-11e3-9046-0002a5d5c51b';
  }

  static const ResolutionValues = {
    1: Resolution.r_4K_169,
    4: Resolution.r_27K_169,
    6: Resolution.r_27K_43,
    7: Resolution.r_1440_169,
    9: Resolution.r_1080_169,
    18: Resolution.r_4K_43,
    24: Resolution.r_5K_169,
    25: Resolution.r_5K_43,
    26: Resolution.r_53K_87,
    27: Resolution.r_53K_43,
    28: Resolution.r_4K_87,
    100: Resolution.r_53K_169,
  };
  static const FPSValues = {
    0: FPS.fps_240,
    1: FPS.fps_120,
    2: FPS.fps_100,
    5: FPS.fps_60,
    6: FPS.fps_50,
    8: FPS.fps_30,
    9: FPS.fps_25,
    10: FPS.fps_24,
    13: FPS.fps_200,
  };
  static const Map<int, dynamic> SettingsMap = {
    2: {'type': Setting.Resolution, 'values': ResolutionValues},
    3: {'type': Setting.FPS, 'values': FPSValues}
  };
  static Map<Setting, int> get SettingsMapReverse {
    Map<Setting, int> result = {};
    for (var key in SettingsMap.keys) {
      var type = SettingsMap[key]['type'];
      result[type] = key;
    }
    return result;
  }
}
