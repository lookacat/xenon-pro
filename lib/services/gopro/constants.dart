// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'settings.dart';

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
  static const ResolutionValuesMeta = {
    Resolution.r_4K_169: {
      'text': '4K 16:9',
      'short': '4K',
    },
    Resolution.r_27K_169: {
      'text': '2.7K 16:9',
      'short': '2.7K',
    },
    Resolution.r_27K_43: {
      'text': '2.7K 4:3',
      'short': '2.7K',
    },
    Resolution.r_1440_169: {
      'text': '1440p 16:9',
      'short': '2K',
    },
    Resolution.r_1080_169: {
      'text': '1080p 16:9',
      'short': 'Full HD',
    },
    Resolution.r_4K_43: {
      'text': '4K 4:3',
      'short': '4K',
    },
    Resolution.r_5K_169: {
      'text': '5K 16:9',
      'short': '5K',
    },
    Resolution.r_5K_43: {
      'text': '5K 4:3',
      'short': '5K',
    },
    Resolution.r_53K_87: {
      'text': '5K 8:7',
      'short': '5K',
    },
    Resolution.r_53K_43: {
      'text': '5K 4:3',
      'short': '5K',
    },
    Resolution.r_4K_87: {
      'text': '4K 8:7',
      'short': '4K',
    },
    Resolution.r_53K_169: {
      'text': '5.3K 16:9',
      'short': '5.3K',
    }
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
  static const FPSValuesMeta = {
    FPS.fps_240: {'text': '240', 'short': '240'},
    FPS.fps_120: {'text': '120', 'short': '120'},
    FPS.fps_100: {'text': '100', 'short': '100'},
    FPS.fps_60: {'text': '60', 'short': '60'},
    FPS.fps_50: {'text': '50', 'short': '50'},
    FPS.fps_30: {'text': '30', 'short': '30'},
    FPS.fps_25: {'text': '25', 'short': '25'},
    FPS.fps_24: {'text': '24', 'short': '24'},
    FPS.fps_200: {'text': '200', 'short': '200'},
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
