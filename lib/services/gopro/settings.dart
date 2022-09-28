import 'constants.dart';
import 'packet.dart';

class SettingsRequest implements RequestPacket {
  Setting setting;
  dynamic value;

  SettingsRequest(this.setting, this.value);

  @override
  List<int> toQuery() {
    var key = Constants.SettingsMapReverse[setting]!;
    var values = Constants.SettingsMap[key]!['values'];
    int valueInt = values.keys.firstWhere((i) => values[i] == value);
    return [3, key, 1, valueInt];
  }
}
