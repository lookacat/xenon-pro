// ignore_for_file: constant_identifier_names

class GoproCommands {
  static const List<int> ShutterOff = [0x03, 0x01, 0x01, 0x00];
  static const List<int> ShutterOn = [0x03, 0x01, 0x01, 0x01];
  static const List<int> PowerOff = [0x01, 0x5];
  static const List<int> SwitchToVideoMode = [0x04, 0x3e, 0x02, 0x03, 0xe8];
  static const List<int> SwitchToPhotoMode = [0x04, 0x3e, 0x02, 0x03, 0xe9];
  static const List<int> SwitchToVideoTimelapse = [
    0x04,
    0x3e,
    0x02,
    0x03,
    0xea
  ];
}
